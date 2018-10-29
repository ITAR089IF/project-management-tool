require 'rails_helper'

RSpec.describe Account::TasksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace, users: [user]) }
  let!(:task) { create_list(:task, 5, project: project) }

  before do
    sign_in user
  end

  context 'GET /projects/:project_id/task/:id' do
    it 'should show task page' do
      get :show, params: { project_id: project.to_param, id: task.first.to_param }
      expect(response).to be_successful
    end
  end

  context 'GET /projects/:project_id/task/new' do
    it 'should show new task page' do
      get :new, params: { project_id: project.to_param }
      expect(response).to be_successful
    end
  end

  context 'PUT /:move' do

    it 'should move task down' do
      put :move, params: {
        project_id: project.to_param,
        id: project.tasks.first.to_param,
        task: {
          row_order_position: :down
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.to_param, project.to_param)
      expect(project.tasks.row_order_asc.first).to eq project.tasks.order(id: :asc).second
    end

    it 'should move task up' do
      put :move, params: {
        project_id: project.to_param,
        id: project.tasks.last.to_param,
        task: {
          row_order_position: :up
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
      expect(project.tasks.row_order_asc.fourth).to eq project.tasks.order(id: :asc).last
    end
  end
end
