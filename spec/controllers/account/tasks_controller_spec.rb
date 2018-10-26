require 'rails_helper'

RSpec.describe Account::TasksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user_id: user.id) }
  let!(:project) { create(:project, workspace_id: workspace.id) }
  let!(:task) { create_list(:task, 5, project_id: project.id) }

  before do
    sign_in user
    user.update(projects: [project])
  end

  after do
    sign_out user
  end

  context 'GET /tasks/new' do
    it 'should create a new task' do
      get :new, params: {
        project_id: project.id,
      }
      expect(response).to be_successful
    end
  end

  context 'POST /tasks' do
    it 'should create a task and redirect to project page' do

      post :create, params: {
        project_id: project.id,
        task: {
          title: 'Test task',
          description: 'test description'
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
    end

    it 'shouldn`t create a task and render page new' do
      get :new, params: {
        project_id: project.id,
      }
      post :create, params: {
        project_id: project.id,
        task: {
          title: '',
          description: ''
        }
      }

      expect(response).to render_template(:new)
    end
  end

  context 'PUT /tasks/:id' do
    it 'should update task and redirect to task page' do
      put :update, params: {
        project_id: project.id,
        id: project.tasks.task.id,
        task: {
          title: 'Test task',
          description: 'test description'
        }
      }

      expect(response).to redirect_to account_project_task_path( project.id, task.id)
    end

    it 'shouldn`t update task and render page edit' do
      put :update, params: {
        project_id: project.id,
        id: project.tasks.task.id,
        task: {
          title: '',
          description: ''
        }
      }

      expect(response).to render_template(:edit)
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
      expect(project.tasks.row_order_asc.first).to eq project.tasks.order(id: :asc).second
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
      expect(project.tasks.row_order_asc.fourth).to eq project.tasks.order(id: :asc).last
    end
  end
end
