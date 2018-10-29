require 'rails_helper'

RSpec.describe Account::ProjectsController, type: :controller do
  render_views
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace) }
  let!(:project_valid_params) { { name: "test_project"} }
  let!(:project_invalid_params) { { name: nil} }

  before do
    sign_in user
  end

  describe "GET #index in Account/Projects controller" do
    it "returns http success" do
      get :index, params: { workspace_id: workspace.id }
      expect(response).to have_http_status(200)
    end
  end
    describe "GET show in Account/Projects controller" do
    it "must return show page" do
      get :show, params: { workspace_id: workspace.id, id: project.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { workspace_id: workspace.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template("account/projects/_form")
    end
  end

  describe "POST create in Account/Projects controller" do
    context "with walid attributes" do
      it "must create new project" do
        expect { post :create, params: { workspace_id: workspace.id, project: project_valid_params } }.to change(Project, :count).by(1)
      end
    end
  
    context "with inwalid attributes" do
      it "must not create a project and render 'new' form" do
        count_before = Project.count
        post :create, params: { workspace_id: workspace.id, project: project_invalid_params }
        expect(Project.count).to eq(count_before)
        expect(response).to render_template("account/projects/_form")
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit in Account/Projects controller" do
    it "must display edit page" do
      get :edit, params: { workspace_id: workspace.id, id: project.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH update in Account/Projects controller" do
    context "with walid attributes" do
      it "must update the project" do
        put :update, params: { workspace_id: workspace.id, id: project.id, project: project_valid_params}
        project.reload
        expect(project.name).to eq(project_valid_params[:name])
      end
    end

    context "with inwalid attributes" do
      it "must not create update the project and render 'edit' form" do
        put :update, params: { workspace_id: workspace.id, id: project.id, project: project_invalid_params}
        expect(project.name).to eq(project.name)
        expect(response).to render_template(:edit)
        expect(response).to render_template("account/projects/_form")
      end
    end
  end

  describe "DELETE #destroy in Account/Projects controller" do
    it "returns http success" do
      delete :destroy, params: { workspace_id: workspace.id, id: project.id }
      expect(Project.find_by(id: project.id)).to eq(nil)
    end
  end

end