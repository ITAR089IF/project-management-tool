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

FactoryBot.define do
  factory :project do
    name { Faker::Name.last_name }
  end
end
