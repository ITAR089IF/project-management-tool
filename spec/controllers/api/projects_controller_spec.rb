require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :controller do
  render_views

  let!(:user)                   { create(:user) }
  let!(:workspace)              { create(:workspace, user: user) }
  let!(:project)                { create(:project, workspace: workspace) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "must return show page" do
      get :show, as: :json, params: { workspace_id: workspace.id, id: project.id }
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response.body).to include(project.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "must create new project" do
        post :create, as: :json, params: {
          workspace_id: workspace.id,
          project: {
            name: Faker::Job.field
          }
         }
         expect(response).to have_http_status(200)
      end
    end

    context "with invalid attributes" do
      it "must not create a project and render 'new' form" do
        post :create, as: :json, params: {
            workspace_id: workspace.id,
            project: {
              name: ''
            }
           }
         expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "must update the project" do
        put :update, as: :json, params: {
          workspace_id: workspace.id,
          id: project.id,
          project: {
            name: Faker::Job.field
          }
        }
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid attributes" do
      it "must not update the project and render 'edit' form" do
        put :update, as: :json, params: {
          workspace_id: workspace.id,
          id: project.id,
          project: {
            name: ''
          }
        }
       project.reload
       expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      expect { delete(:destroy, as: :json, params: { workspace_id: workspace.to_param,
        id: project.to_param }) }.to change(Project, :count).by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
