require 'rails_helper'

RSpec.describe Account::ProjectsController, type: :controller do
  render_views

  let!(:user)                   { create(:user) }
  let!(:workspace)              { create(:workspace, user: user) }
  let!(:project)                { create(:project, workspace: workspace) }
  let!(:project_valid_params) { { name: "test_project"} }
  let!(:project_invalid_params) { { name: nil} }

  context "when user sign in" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, params: { workspace_id: workspace.to_param }
        expect(response).to have_http_status(200)
      end
    end
    
    describe "GET #show" do
      it "must return show page" do
        get :show, params: { workspace_id: workspace.to_param, id: project.to_param }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, params: { workspace_id: workspace.to_param }
        expect(response).to have_http_status(200)
        expect(response).to render_template("account/projects/_form")
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "must create new project" do
          expect { post :create, params: { workspace_id: workspace.to_param, project: project_valid_params } }.to change(Project, :count).by(1)
        end
      end
      context "with invalid attributes" do
        it "must not create a project and render 'new' form" do
          expect { post(:create, params: { workspace_id: workspace.to_param, project: project_invalid_params }) }.to change(Project, :count).by(0)
        end
      end
    end

    describe "GET #edit" do
      it "must display edit page" do
        get :edit, params: { workspace_id: workspace.to_param, id: project.to_param }
        expect(response).to render_template(:edit)
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "must update the project" do
          put :update, params: { workspace_id: workspace.to_param, id: project.to_param, project: project_valid_params}
          project.reload
          expect(project.name).to eq(project_valid_params[:name])
        end
      end
      context "with invalid attributes" do
        it "must not update the project and render 'edit' form" do
          put :update, params: { workspace_id: workspace.to_param, id: project.to_param, project: project_invalid_params}
          project.reload
          expect(project.name).not_to eq(project_invalid_params[:name])
          expect(response).to render_template("account/projects/_form")
        end
      end
    end

    describe "DELETE #destroy" do
      it "returns http success" do
        expect { delete(:destroy, params: { workspace_id: workspace.to_param, id: project.to_param }) }.to change(Project, :count).by(-1)
      end
    end
  end

  context "when user is not signed in" do
    describe "GET #show" do
      it "must return root page" do
        get :show, params: { workspace_id: workspace.to_param, id: project.to_param }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end