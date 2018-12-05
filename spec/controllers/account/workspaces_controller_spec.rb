require 'rails_helper'

RSpec.describe Account::WorkspacesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:workspace1) { create(:workspace, user: user1) }
  let!(:shared_workspace) { create(:shared_workspace, user: user, workspace: workspace1) }
  let!(:shared_workspace1) { create(:shared_workspace, user: user2, workspace: workspace1) }

  before do
    sign_in user
    allow(Bitly).to receive_message_chain(:client, :shorten, :short_url) { 'http://bit.ly/1111111' }
  end

  context 'GET /workspace/new' do
    it 'should show page create new workspace' do
      get :new, format: :js, xhr: true
      expect(response).to be_successful
    end
  end

  context 'GET /worspaces/:id' do
    it 'should show page with workspace' do
      get :show, params: { id: workspace.id }
      expect(response).to be_successful
    end
  end

  context 'GET /worspaces/:id/prepare_pdf' do
    it 'should send workspace details to email' do
      get :prepare_pdf, params: { id: workspace.id }, xhr: true
      ActiveJob::Base.queue_adapter = :test
      expect{ WorkspaceDetailsJob.perform_later(workspace, user) }.to enqueue_job
    end
  end

  context 'GET /worspaces/:id/list' do
    it 'should show page with list of tasks' do
      get :list, params: { id: workspace.id }
      expect(response).to be_successful
    end
  end

  context 'GET /workspaces/:id/edit' do
    it 'should show page edit' do
      get :edit, params: { id: workspace.id }, format: :js, xhr: true
      expect(response).to be_successful
    end
  end

  context 'POST /workspaces' do
    it 'should create a workspace' do
      expect { post :create, params: {
        workspace: {
          name: Faker::Job.field
        }
      }, format: :js, xhr: true }.to change(Workspace, :count).by(1)
    end

    it 'shouldn`t create a workspace' do
      expect { post :create, params: {
        workspace: {
          name: ''
        }
      }, format: :js, xhr: true }.to change(Workspace, :count).by(0)
    end
  end

  context 'PUT /workspace/:id' do
    it 'should update workspace and redirect to workspaces page' do
      put :update, params: {
        id: workspace.id,
        workspace: {
          name: 'Test text'
        }
      }, format: :js, xhr: true

      workspace.reload

      expect(workspace.name).to eq 'Test text'
    end


    it 'shouldn`t update workspace' do
      put :update, params: {
        id: workspace.id,
        workspace: {
          name: ''
        }
      }, format: :js, xhr: true

      workspace.reload

      expect(workspace.name).to_not eq ''
    end
  end

  context '#DELETE /workspace/:id' do
    it 'should delete workspace' do
      expect{ delete :destroy, params: { id: workspace.id }, format: :js, xhr: true }.to change(Workspace, :count).by(-1)
    end
  end

  context '#CREATE /create_invitation_link' do
    subject { post :create_invitation_link, params: { workspace_id: workspace.id }, format: :js }
    it 'creates new invitation' do
      expect{ subject }.to change(Invitation, :count).by(1)
      expect(response).to render_template :create_invitation_link
    end
  end
end
