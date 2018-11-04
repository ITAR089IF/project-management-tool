class Task < ApplicationRecord
  include RankedModel

  ranks :row_order, with_same: :project_id

  has_many_attached :files, dependent: :destroy
  belongs_to :project, required: true
  has_many :task_watches, dependent: :destroy
  has_many :watchers, through: :task_watches, source: :user
  has_one :assignee, dependent: :destroy
  has_one :assigned_user, through: :assignee, source: :user

  scope :incomplete, -> { where(complete: false) }
  scope :complete, -> { where(complete: true) }
  scope :row_order_asc, -> { order(row_order: :asc) }

  validates :title, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 250 }

  def pending?
    !complete?
  end

  def add_watcher(user)
    self.task_watches.find_or_create_by(user_id: user.id)
  end

  def remove_watcher(user)
    self.task_watches.where(user_id: user.id).delete_all
  end
end
