require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace) }
  let!(:task1) { create(:task, project: project) }
  let!(:task2) { create(:task, project: project) }
  let!(:task_valid_params) { { title: "test_task"} }
  let!(:task_invalid_params) { { title: nil} }

  before do
    sign_in user
  end

  describe 'GET /projects/:project_id/task/:id' do
    it 'should show task page' do
      get :show, as: :json, params: { project_id: project.id, id: task1.id }
      parsed_response = JSON.parse(response.body)
      expect(response.body).to include(task1.title)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /projects/:project_id/tasks' do
    context "with valid attributes" do
      it 'should create task' do
        post :create, as: :json, params: {
          project_id: project.id,
          task: {
            title: Faker::Lorem.sentence,
            description: Faker::Lorem.paragraph
          }
        }

        expect{ post :create, params: { project_id: project.id, task: { title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph }}}.to change(Task, :count).by(1)
        expect(response).to have_http_status(201)
        expect(response).to render_template(:show)
      end
    end
    context "with invalid attributes" do
      it 'should not create task' do
        post :create, as: :json, params: {
          project_id: project.id,
          task: {
            title: ''
          }
        }
        expect{ post :create, params: { project_id: project.id, task: { title: '' }}}.to change(Task, :count).by(0)
        expect(response).to have_http_status(422)
      end
    end
  end


  describe "PATCH #update" do
    context "with valid attributes" do
      it "must update the project" do
        put :update, params: { project_id: project.id, id: task1.id, task: task_valid_params}
        task1.reload
        expect(task1.title).to eq(task_valid_params[:title])
        expect(response).to have_http_status(201)
        expect(response).to render_template(:show)
      end
    end

    context "with invalid attributes" do
      it "must not update the project and render 'edit' form" do
        put :update, params: { project_id: project.id, id: task1.id, task: task_invalid_params}
        task1.reload
        expect(task1.title).not_to eq(task_invalid_params[:title])
        expect(response).to have_http_status(422)
      end
    end
  end


  describe 'DELETE/projects/:project_id/tasks/:id' do
    it 'should delete task' do
      expect(project.tasks.count).to eq 2
      delete :destroy, params: { project_id: project.id, id: task1.id }
      expect(project.tasks.count).to eq 1
      expect(response).to have_http_status(:ok)
    end
  end
end
