# == Schema Information
#
# Table name: tasks
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  row_order   :integer
#  section     :boolean
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
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user_id: user.id) }
  let!(:project) { create(:project, workspace_id: workspace.id) }
  let!(:task1) { create(:task, project_id: project.id) }
  let!(:task2) { create(:task, project_id: project.id) }
  let!(:task3) { create(:task, project_id: project.id) }

  context 'test before_save :section' do
    let!(:task5) { create(:task, project_id: project.id) }
    let!(:task6) { create(:task, title: 'Section:',  project_id: project.id) }
    let!(:task7) { create(:task, title: 'Test : text') }

    it 'should set status section as false' do
      expect(task5.section).to eq false
    end

    it 'should set status section as true' do
      expect(task6.section).to eq true
    end

    it 'shold set status section as false if double quots not in the end' do
      expect(task7.section).to eq false
    end
  end

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
