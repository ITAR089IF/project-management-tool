# == Schema Information
#
# Table name: invitations
#
#  id           :bigint(8)        not null, primary key
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  invitor_id   :bigint(8)
#  workspace_id :bigint(8)
#
# Indexes
#
#  index_invitations_on_invitor_id    (invitor_id)
#  index_invitations_on_workspace_id  (workspace_id)
#

FactoryBot.define do
  factory :invitation do
    association :invitor, factory: :user
    workspace
    token { Devise.friendly_token }
  end
end
