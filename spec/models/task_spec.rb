# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint(8)
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_row_order   (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'scope testing' do
    let!(:user) { create(:user) }
    let!(:workspace) { create(:workspace, user_id: user.id) }
    let!(:project) { create(:project, workspace_id: workspace.id) }
    let!(:task1) { create(:task, project_id: project.id) }
    let!(:task2) { create(:task, project_id: project.id) }
    let!(:task3) { create(:task, project_id: project.id) }

    it 'shold order by row_order asc' do
      project.tasks.first.update(row_order_position: :down)
      expect(project.tasks.row_order_asc).to eq [task2, task1, task3]
    end
  end
end
