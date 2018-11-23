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

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:invitation) { create(:invitation, invitor: user, workspace: workspace, created_at:  1.days.ago) }
  let!(:outdated_invitation) { create(:invitation, invitor: user, workspace: workspace, created_at: 150.days.ago) }

  context 'factory tests' do
    subject { build(:invitation) }
    it { is_expected.to be_valid }
  end
  
  context '.expired?' do
    context 'outdated invitation' do
      it { expect(outdated_invitation.expired?).to be true }
    end

    context 'valid invitation' do
      it { expect(invitation.expired?).to be false }
    end
  end
end
