require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'scope testing' do
    let!(:user) { create(:user) }
    let!(:workspace) { create(:workspace, user_id: user.id) }
    let!(:project) { create_list(:project, 10, workspace_id: workspace.id) }

    it 'should sort data by desc' do
      expect(Project.order_desc).to eq Project.order(id: :desc)
    end
  end
end
