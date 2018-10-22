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

class Project < ApplicationRecord
  has_many :tasks
  belongs_to :workspace

  validates :name, length: { maximum: 250 }, presence: true
end
