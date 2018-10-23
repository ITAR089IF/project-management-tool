# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_workspaces_on_user_id  (user_id)
#

FactoryBot.define do
  factory :workspace do
    name { Faker::Name.first_name }
  end
end
