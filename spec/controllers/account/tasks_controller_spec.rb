require 'rails_helper'

RSpec.describe Account::TasksController, type: :controller do
  context 'PUT /:move' do
    let!(:user) { create(:user) }
    let!(:workspace) { create(:workspace, user_id: user.id) }
    let!(:project) { create(:project, workspace_id: workspace.id) }
    let!(:task) { create_list(:task, 5, project_id: project.id) }

    before do
      sign_in user
    end

    after do
      sign_out user
    end

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
