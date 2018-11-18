# == Schema Information
#
# Table name: invitations
#
#  id           :bigint(8)        not null, primary key
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  invitor_id   :integer
#  workspace_id :integer
#

FactoryBot.define do
  factory :invitation do
    invitor_id { 1 }
    workspace_id { 1 }
    token Faker::Lorem.characters(20)
  end
end
