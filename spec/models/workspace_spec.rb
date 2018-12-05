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
#  index_workspaces_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:workspace1) { create(:workspace, user: user) }
  let!(:workspace2) { create(:workspace, user: user) }
  let!(:workspace3) { create(:workspace, user: user) }
  let!(:shared_workspace) { create(:shared_workspace, user: user1, workspace: workspace1) }

  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:workspace) { build(:workspace, user: user) }

    it { expect validate_presence_of :name }
    it { expect validate_length_of :name }
    it { expect belong_to :user }
  end

  context 'scope tests' do
    let!(:user) { create(:user) }
    let!(:workspace1) { create(:workspace, name: 'IT Innovation', user: user) }
    let!(:workspace2) { create(:workspace, name: 'Inntroduction', user: user) }
    let!(:workspace3) { create(:workspace, name: 'Abrams', user: user) }

    it 'should be sort by desc' do
      expect(user.workspaces.order_asc).to eq [workspace3, workspace2, workspace1]
    end

    it 'should find workspaces with entered text' do
      expect(user1.available_workspaces.search_workspaces('iT inn').count).to eq 1
      expect(user.available_workspaces.search_workspaces('inn').count).to eq 2
      expect(user.available_workspaces.search_workspaces('hasgd').count).to eq 0
    end
  end

  context '.all_members' do
    it { expect(workspace1.all_members).to contain_exactly(user, user1) }
  end

  context '.potential_members' do
    it { expect(workspace1.potential_members).to contain_exactly(user2, user3) }
  end
end
