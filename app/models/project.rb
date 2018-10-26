# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  workspace_id :bigint(8)
#
# Indexes
#
#  index_projects_on_workspace_id  (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (workspace_id => workspaces.id)
#

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :workspace, required: true
  has_many :tasks, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects

  scope :order_desc, -> { order(id: :desc) }

  validates :name, length: { maximum: 250 }, presence: true
  paginates_per  5
end
