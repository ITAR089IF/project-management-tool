# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  deleted_at   :datetime
#  description  :text
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  workspace_id :bigint(8)
#
# Indexes
#
#  index_projects_on_deleted_at    (deleted_at)
#  index_projects_on_workspace_id  (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (workspace_id => workspaces.id)
#

class Project < ApplicationRecord
  include Commentable
  acts_as_paranoid
  belongs_to :workspace, required: true
  has_many :tasks, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  scope :order_desc,      -> { order(id: :desc) }
  scope :search_projects, -> (search) { select('projects.id, projects.name, projects.workspace_id').where("name ILIKE ?", "%#{search}%").order(name: :asc).limit(10) }

  validates :name, length: { maximum: 250 }, presence: true
  validates :description, length: { maximum: 500 }
end
