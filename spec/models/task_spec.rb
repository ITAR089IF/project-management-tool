require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'scope testing' do
    let!(:user) { create(:user) }
    let!(:workspace) { create(:workspace, user_id: user.id) }
    let!(:project) { create(:project, workspace_id: workspace.id) }
    let!(:task) { create_list(:task, 10, project_id: project.id) }

    it 'shold order by row_order asc' do
      expect(Task.row_order_asc).to eq Task.order(row_order: :asc)
    end
  end
end
