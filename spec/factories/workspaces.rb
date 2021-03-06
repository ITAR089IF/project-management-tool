# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_workspaces_on_deleted_at  (deleted_at)
#  index_workspaces_on_name        (name)
#  index_workspaces_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :workspace do
    name { Faker::Job.field }

    user
  end
end
