# == Schema Information
#
# Table name: tasks
#
#  id           :bigint(8)        not null, primary key
#  completed_at :datetime
#  deleted_at   :datetime
#  description  :text
#  due_date     :datetime
#  row_order    :integer
#  section      :boolean          default(FALSE)
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  assignee_id  :bigint(8)
#  project_id   :bigint(8)
#
# Indexes
#
#  index_tasks_on_assignee_id  (assignee_id)
#  index_tasks_on_deleted_at   (deleted_at)
#  index_tasks_on_project_id   (project_id)
#  index_tasks_on_row_order    (row_order)
#
# Foreign Keys
#
#  fk_rails_...  (assignee_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace, users: [user]) }
  let!(:task1) { create(:task, title: 'deploy to heroku', project: project) }
  let!(:task2) { create(:task, title: 'workspace', project: project) }
  let!(:task3) { create(:task, title: 'deploy to digital oceane',   project: project) }

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

  context 'search' do
    it 'should find all tasks' do
      expect(Task.all.search_tasks(user.id, 'deplo').count).to eq 2
      expect(Task.search_tasks(user.id, 'worksp').count).to eq 1
      expect(Task.search_tasks(user.id, 'igital').count).to eq 0
    end
  end
end
