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

class Invitation < ApplicationRecord
  belongs_to :workspace
  belongs_to :invitor, class_name: "User"

  def expired?
    created_at < 14.days.ago
  end
end
