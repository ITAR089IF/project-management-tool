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
  belongs_to :workspace, required: true
  has_many :tasks, dependent: :destroy

  scope :order_desc, -> { order(id: :desc) }

  validates :name, length: { maximum: 250 }, presence: true
end
