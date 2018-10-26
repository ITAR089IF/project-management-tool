require 'rails_helper'

RSpec.describe Account::CommentsController, type: :controller do
  let(:project) { create :project }
  let(:task) { create :task, project: project }
  let(:params) { name: 'ProjectName' }

  subject { post :create, params: params, user: user }
  it 'creates project' do
    expect(response.status).to eq 302
    expect(subject).to change{ Project.count }.by 1
end
