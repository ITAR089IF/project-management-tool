# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  workspace_id :integer
#
# Indexes
#
#  index_projects_on_workspace_id  (workspace_id)
#

class Project < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  belongs_to :workspace

  validates :name, length: { maximum: 250 }, presence: true

  scope :order_desc, -> { order(id: :desc) }
end
