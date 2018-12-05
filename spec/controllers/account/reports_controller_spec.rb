require 'rails_helper'

RSpec.describe Account::ReportsController, type: :controller do
  render_views

  let!(:user){ create(:user) }
  let!(:workspace){ create(:workspace, user: user) }
  let!(:projects) { create_list(:project, 2, workspace: workspace) }

  before do
    sign_in user
  end

  describe 'GET /report/workspaces/:workspace_id' do
    it 'should show report for all projects in workspace' do
      get :workspace, params: { workspace_id: workspace.id }

      expect(response).to be_successful
    end
  end

  describe 'GET /report/workspaces/:workspace_id/projects/:id' do
    it 'should show report for project' do
      get :project, params: { workspace_id: workspace.id, id: projects.first.id }, format: :js, xhr: true

      expect(response).to be_successful
    end
  end
end
