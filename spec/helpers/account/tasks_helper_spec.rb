require 'rails_helper'

RSpec.describe Account::TasksHelper, type: :helper do
  let!(:user)         { create(:user) }
  let!(:workspace)    { create(:workspace, user: user) }
  let!(:project)      { create(:project, workspace: workspace, users: [user]) }

  context 'section' do
    let!(:task) { create(:task, project: project, section: true) }

    subject { helper.task_link_class(task) }
  
    it { is_expected.to include('title') }
    it { is_expected.to include('is-4') }
    it { is_expected.to include('is-italic') }
  end
  
  context 'expired' do
    let!(:task) { create(:task, :expired, project: project) }

    subject { helper.task_link_class(task) }
  
    it { is_expected.to eq('has-text-danger') }
  end

  context 'future task' do
    let!(:task) { create(:task, :future, project: project) }

    subject { helper.task_link_class(task) }
  
    it { is_expected.to eq('has-text-link') }
  end
end
