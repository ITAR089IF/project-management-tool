# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  complete    :boolean          default(FALSE)
#  deleted_at  :datetime
#  description :text
#  row_order   :integer
#  section     :boolean          default(FALSE)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint(8)
#
# Indexes
#
#  index_tasks_on_deleted_at  (deleted_at)
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_row_order   (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace) }
  let!(:task1) { create(:task, project: project) }
  let!(:task2) { create(:task, project: project) }
  let!(:task3) { create(:task, project: project) }

  context 'scope testing' do
    it 'shold order by row_order asc' do
      project.tasks.first.update(row_order_position: :down)
      expect(project.tasks.row_order_asc).to eq [task2, task1, task3]
    end
  end

  context 'factory tests' do
    subject { build(:task) }
    it { is_expected.to be_valid }
  end
end
