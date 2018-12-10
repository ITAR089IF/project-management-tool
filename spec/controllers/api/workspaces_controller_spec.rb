require 'rails_helper'

RSpec.describe Api::WorkspacesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:workspace1) { create(:workspace, user: user1) }

  before do
    sign_in user
  end

  context 'GET /workspaces' do
    it 'should show all user workspaces' do
      get :index, as: :json
      expect(response).to have_http_status(200)
    end
  end

  context 'GET /worspaces/:id' do
    it 'should show page with workspace' do
      get :show, as: :json, params: { id: workspace.id }
      parsed_response = JSON.parse(response.body)
      expect(response.body).to include(workspace.name)
    end

    it 'returns status code 200' do
      get :show, as: :json, params: { id: workspace.id }
      expect(response).to have_http_status(200)
    end
  end

  context 'POST /workspaces' do
    it 'should create a workspace ' do
      post :create, as: :json, params: {
        workspace: {
          name: Faker::Job.field
        }
      }
      expect(response).to render_template(:show)
    end

    it 'shouldn`t create a workspace ' do
      post :create, as: :json, params: {
        workspace: {
          name: ''
        }
      }

      expect(response).to have_http_status(422)
    end
  end

  context 'PUT /workspace/:id' do
    it 'should update workspace' do
      put :update, as: :json, params: {
        id: workspace.id,
        workspace: {
          name: Faker::Job.field
        }
      }
      expect(response).to render_template(:show)
    end

    it 'shouldn`t update workspace' do
      put :update,  as: :json, params: {
        id: workspace.id,
        workspace: {
          name: ''
        }
      }
      expect(response).to have_http_status(422)
    end
  end

  context '#DELETE /workspace/:id' do
    it 'should delete workspace' do
      delete :destroy, params: { id: workspace.id }

      expect(response).to have_http_status(:ok)
    end
  end
end
