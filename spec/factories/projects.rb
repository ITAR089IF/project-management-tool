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
#  index_projects_on_name          (name)
#  index_projects_on_workspace_id  (workspace_id)
#
# Foreign Keys
#
#  fk_rails_...  (workspace_id => workspaces.id)
#

FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    description { Faker::Lorem.paragraph }

    workspace
  end
end
