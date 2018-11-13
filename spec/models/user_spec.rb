# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  about                  :text
#  department             :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  job_role               :string
#  last_name              :string
#  oauth_expires_at       :string
#  oauth_token            :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("user")
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, first_name: 'John', last_name: 'Doe') }
  let!(:user1) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:project) { create(:project, users: [user]) }
  let!(:task) { create(:task, project: project) }
  let!(:projects_comment) { create(:comment, :for_project,  user: user, commentable: project) }
  let!(:tasks_comment) { create(:comment, :for_task,  user: user, commentable: task) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:shared_workspace1) { create(:shared_workspace, user: user1, workspace: workspace) }

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

  context '.for_workspace' do
    it { expect(described_class.for_workspace(workspace)).to contain_exactly(user, user1) }
  end
end
