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

class Invitation < ApplicationRecord
  belongs_to :workspace
  belongs_to :invitor, class_name: "User"

  def expired?
    created_at < 14.days.ago
  end
end
