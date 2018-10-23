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

require 'rails_helper'

RSpec.describe Workspace, type: :model do
  context 'validation tests' do
    let(:user) { create(:user) }
    let(:workspace) { build(:workspace, user_id: user.id) }

    it 'name should be presence' do
      expect(workspace.valid?).to eq true
    end

    it 'should be invalid if name empty' do
      workspace.name = ''
      expect(workspace.valid?).to eq false
    end

    it 'shouldn`t be saved without user_id' do
      workspace.user_id = ''
      expect(workspace.valid?).to eq false
    end

    it 'name length must be less then 30' do
      workspace.name = '*' * 31
      expect(workspace.valid?).to eq false
    end
  end
end
