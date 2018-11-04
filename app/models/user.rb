class User < ApplicationRecord
  has_many :workspaces, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :task_watches, dependent: :destroy
  has_many :tasks, through: :task_watches
  has_many :assigned_task, through: :assignee, dependent: :destroy

  validates :first_name, length: { maximum: 250 }, presence: true
  validates :last_name, length: { maximum: 250 }, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

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

  def watching?(task)
    self.tasks.where(id: task.id).exists?
  end
end
