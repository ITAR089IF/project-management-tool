# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  about                  :text
#  dashboard_layout       :json
#  deleted_at             :datetime
#  department             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  job_role               :string
#  last_name              :string
#  oauth_expires_at       :string
#  oauth_token            :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("user")
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  ADMIN = 'admin'
  USER = 'user'
  acts_as_paranoid

  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :workspaces, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :task_watches, dependent: :destroy
  has_many :created_tasks, class_name: "Task", foreign_key: :creator_id
  has_many :followed_tasks, through: :task_watches, source: :task
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id
  has_many :completed_tasks, class_name: "Task", foreign_key: :completed_by_id
  has_many :shared_workspaces
  has_many :invited_workspaces, through: :shared_workspaces, source: :workspace
  has_one_attached :avatar

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true
  validates :role, length: { maximum: 250 }
  validates :department, length: { maximum: 250 }
  validates :about, length: { maximum: 250 }
  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  scope :order_desc,  -> { order(:first_name, :last_name) }
  scope :admins,      -> { where(role: ADMIN) }
  scope :none_admins, -> { where(role: USER) }

  after_create :notify_admins_about_new_user

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first do |user|
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.email = auth.info.email
        user.uid = auth.uid
        user.provider = auth.provider
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def can_manage?(comment)
    comments.where(id: comment.id).exists?
  end

  def watching?(task)
    self.followed_tasks.where(id: task.id).exists?
  end

  def with_avatar?
    avatar&.attachment&.blob&.persisted?
  end

  def available_workspaces
    workspaces.union(self.invited_workspaces).order_asc
  end

  def available_projects
    Project.where(workspace_id: available_workspaces.ids)
  end

  def admin?
    self.role == ADMIN
  end

  def notify_admins_about_new_user
    UsersMailer.send_new_user_message(self).deliver_later
  end
end
