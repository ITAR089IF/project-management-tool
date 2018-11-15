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
  end

  context 'GET /workspaces' do
    it 'should show all user workspaces' do
      get :index
      expect(response).to be_successful
    end
  end

  context 'GET /workspace/new' do
    it 'should show page create new workspace' do
      get :new
      expect(response).to be_successful
    end
  end

  context 'GET /worspaces/:id' do
    it 'should show page with workspace' do
      get :show, params: { id: workspace.id }
      expect(response).to be_successful
    end
  end

  context 'GET /workspaces/:id/edit' do
    it 'should show page edit' do
      get :edit, params: { id: workspace.id }
      expect(response).to be_successful
    end
  end

  context 'POST /workspaces' do
    it 'should create a workspace and redirect to workspaces page' do
      post :create, params: {
        workspace: {
          name: 'Test workspace'
        }
      }

      expect(response).to redirect_to account_workspaces_path
    end

    it 'shouldn`t create a workspace and render page new' do
      post :create, params: {
        workspace: {
          name: ''
        }
      }

      expect(response).to render_template(:new)
    end
  end
  
  context 'PUT /workspace/:id' do
    it 'should update workspace and redirect to workspaces page' do
      put :update, params: {
        id: workspace.id,
        workspace: {
          name: 'Test text'
        }
      }

      expect(response).to redirect_to account_workspace_path(workspace.id)
    end

    it 'shouldn`t update workspace and render page edit' do
      put :update, params: {
        id: workspace.id,
        workspace: {
          name: ''
        }
      }

      expect(response).to render_template(:edit)
    end
  end

  context '#DELETE /workspace/:id' do
    it 'should delete workspace' do
      delete :destroy, params: { id: workspace.id }

      expect(response).to redirect_to account_workspaces_path
    end
  end
end
