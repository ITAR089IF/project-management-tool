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
    association :invitor, factory: :user
    workspace
    token { Devise.friendly_token }
  end
end
