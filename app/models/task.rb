# == Schema Information
#
# Table name: tasks
#
#  id              :bigint(8)        not null, primary key
#  completed_at    :datetime
#  deleted_at      :datetime
#  description     :text
#  due_date        :datetime
#  row_order       :integer
#  section         :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  assigned_by_id  :integer
#  assignee_id     :bigint(8)
#  completed_by_id :integer
#  creator_id      :bigint(8)
#  project_id      :bigint(8)
#
# Indexes
#
#  index_tasks_on_assigned_by_id   (assigned_by_id)
#  index_tasks_on_assignee_id      (assignee_id)
#  index_tasks_on_completed_by_id  (completed_by_id)
#  index_tasks_on_creator_id       (creator_id)
#  index_tasks_on_deleted_at       (deleted_at)
#  index_tasks_on_project_id       (project_id)
#  index_tasks_on_row_order        (row_order)
#  index_tasks_on_title            (title)
#
# Foreign Keys
#
#  fk_rails_...  (assignee_id => users.id)
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#

class Task < ApplicationRecord
  include RankedModel
  include Commentable

  acts_as_paranoid

  ranks :row_order, with_same: :project_id

  has_many_attached :files, dependent: :destroy
  belongs_to :project, required: true
  has_many :task_watches, dependent: :destroy
  has_many :watchers, through: :task_watches, source: :user
  belongs_to :assignee, class_name: "User", required: false
  belongs_to :creator, class_name: "User", required: true
  belongs_to :completed_by, class_name: "User", foreign_key: :completed_by_id, optional: true

  scope :incomplete,        -> { where(completed_at: nil) }
  scope :complete,          -> { where.not(completed_at: nil).order(completed_at: :desc) }
  scope :complete_by,       -> (user) { where("completed_by_id = ?", user.id) }
  scope :row_order_asc,     -> { order(row_order: :asc) }
  scope :search_tasks,      -> (search) { select('tasks.id, tasks.title, tasks.project_id')
                                                    .where('tasks.title ILIKE ?',"%#{search}%")
                                                    .limit(10) }
  scope :this_week,         -> { where('created_at > ?', Date.today.beginning_of_week) }
  scope :current_workspace, -> (workspace) { joins(:project).merge(workspace.projects) }
  scope :completed_tasks_with_assignee, -> { where.not(assignee_id: nil, completed_at: nil).group(:assignee_id).count }
  scope :completed_tasks_without_assignee, -> { where(assignee_id: nil).where.not(completed_at: nil, completed_by_id: nil).group(:completed_by_id).count }

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }

  alias_attribute :start_time, :due_date

  def pending?
    !completed_at?
  end

  def expired?
    self.due_date && self.due_date < Date.today && pending?
  end

  def add_watcher(user)
    self.task_watches.find_or_create_by(user_id: user.id)
  end

  def remove_watcher(user)
    self.task_watches.where(user_id: user.id).delete_all
  end

  def assign!(assignee_id, user)
    result = update(assignee_id: assignee_id, assigned_by_id: user.id)
    send_notifications("Task '#{self.title}' has been assigned to #{assignee.full_name} by #{user.full_name}", self.watchers + [assignee] - [user]) if result
    result
  end

  def complete!(user)
    self.update(completed_at: Time.now, completed_by: user)
    send_notifications("Task '#{self.title}' has been completed by #{user.full_name}", self.watchers - [user])
    TasksMailer.task_completed(self, user).deliver_later
  end

  def assignee?(user)
    assignee == user
  end

  def Task.report
    { complete: complete.count, incomplete: incomplete.count }
  end

  def Task.users_report
    completed_tasks = completed_tasks_with_assignee.merge(completed_tasks_without_assignee){ |key, old_value, new_value| old_value + new_value }

    report = {}

    completed_tasks.each_key do |user_id|
      user = User.find(user_id).full_name
      report[user] = completed_tasks[user_id]
    end

    report
  end

  private

  def send_notifications(message, notify_users = self.watchers)
    notify_users.uniq.each do |user|
      user.messages.create(body: message, messageable: self)
      NotificationsJob.perform_later(user)
    end
  end

end
