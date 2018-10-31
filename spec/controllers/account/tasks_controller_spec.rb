require 'rails_helper'

RSpec.describe Account::TasksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace, users: [user]) }
  let!(:task1) { create(:task, project: project) }
  let!(:task2) { create(:task, project: project, users: [user]) }
  let!(:task3) { create(:task, project: project) }

  before do
    sign_in user
  end

  context 'GET /projects/:project_id/task/:id' do
    it 'should show task page' do
      get :show, params: { project_id: project.id, id: task1.id }
      expect(response).to be_successful
    end
  end

  context 'GET /projects/:project_id/task/new' do
    it 'should show new task page' do
      get :new, params: { project_id: project.id }
      expect(response).to be_successful
    end
  end

  context 'POST /projects/:project_id/tasks' do
    it 'should create task' do
      post :create, params: {
        project_id: project.id,
        task: {
          title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph
        }
      }

      expect{ post :create, params: { project_id: project.id, task: { title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph }}}.to change(Task, :count).by(1)
    end
  end

  context 'PUT /:move' do

    it 'should move task down' do
      put :move, params: {
        project_id: project.id,
        id: project.tasks.first.id,
        task: {
          row_order_position: :down
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
      expect(project.tasks.row_order_asc).to eq [task2, task1, task3]
    end

    it 'should move task up' do
      put :move, params: {
        project_id: project.id,
        id: project.tasks.last.id,
        task: {
          row_order_position: :up
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
      expect(project.tasks.row_order_asc).to eq [task1, task3, task2]
    end
  end

  context 'GET /watch' do
    it 'should follow task' do
      get :watch, params: { project_id: project.id, id: task1.id }, format: :js
      expect(task1.users).to include user
    end

    it 'should unfollow task' do
      get :watch, params: { project_id: project.id, id: task2.id }, format: :js
      expect(Task.second.users).to_not include user
    end
  end
end
