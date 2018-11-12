# == Schema Information
#
# Table name: workspaces
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_workspaces_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  context 'validation tests' do
    let!(:user) { create(:user) }
    let!(:workspace) { build(:workspace, user: user) }

    it { expect validate_presence_of :name }
    it { expect validate_length_of :name }
    it { expect belong_to :user }
  end

  context 'scope tests' do
    let!(:user) { create(:user) }
    let!(:workspace1) { create(:workspace, name: 'IT', user: user) }
    let!(:workspace2) { create(:workspace, name: 'Infrastructure', user: user) }
    let!(:workspace3) { create(:workspace, user: user) }

    it 'should be sort by desc' do
      expect(user.workspaces.order_desc).to eq [workspace3, workspace2, workspace1]
    end

    it 'should find workspaces with entered text' do
      expect(user.workspaces.search_workspaces('iN').count).to eq 1
      expect(user.workspaces.search_workspaces('I').count).to eq 2
      expect(user.workspaces.search_workspaces('nfras').count).to eq 0
    end
  end
end
