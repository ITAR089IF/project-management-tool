
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, first_name: 'John', last_name: 'Doe') }
  let!(:another_user) { create(:user) }
  let!(:project) { create(:project) }
  let!(:task) { create(:task, project: project) }
  let!(:projects_comment) { create(:comment, :for_project,  user: user, commentable: project) }
  let!(:tasks_comment) { create(:comment, :for_task,  user: user, commentable: task) }

  context 'returns full name' do
    it { expect(user.full_name).to eq 'John Doe' }
  end

  context 'can manage own project comment' do
    it { expect(user.can_manage?(projects_comment)).to be true }
    it { expect(another_user.can_manage?(projects_comment)).to be false }
  end

  context 'can manage own task comment' do
    it { expect(user.can_manage?(tasks_comment)).to be true }
    it { expect(another_user.can_manage?(tasks_comment)).to be false }
  end

  context 'factory tests' do
    subject { build(:user) }
    it { is_expected.to be_valid }
  end

  context 'validation tests' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should have_many(:projects) }
    it { should validate_length_of(:first_name).is_at_most(250) }
    it { should validate_length_of(:last_name).is_at_most(250) }
  end
end
