require 'rails_helper'

RSpec.describe Account::WorkspacesHelper, type: :helper do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  let!(:workspace) { create(:workspace, user: user) }
  let!(:shared_workspace) { create(:shared_workspace, user: user1, workspace: workspace) }
  let!(:shared_workspace1) { create(:shared_workspace, user: user2, workspace: workspace) }

  context 'uninvited_users' do
    it { expect(uninvited_users(workspace)).to contain_exactly(user3) }
  end
end
