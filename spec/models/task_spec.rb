# == Schema Information
#
# Table name: tasks
#
#  id              :bigint(8)        not null, primary key
#  assigned_at     :datetime
#  completed_at    :datetime
#  deleted_at      :datetime
#  description     :text
#  due_date        :datetime
#  row_order       :integer
#  section         :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  assigned_by_id  :integer
#  assignee_id     :bigint(8)
#  completed_by_id :integer
#  creator_id      :bigint(8)
#  project_id      :bigint(8)
#
# Indexes
#
#  index_tasks_on_assigned_by_id   (assigned_by_id)
#  index_tasks_on_assignee_id      (assignee_id)
#  index_tasks_on_completed_by_id  (completed_by_id)
#  index_tasks_on_creator_id       (creator_id)
#  index_tasks_on_deleted_at       (deleted_at)
#  index_tasks_on_project_id       (project_id)
#  index_tasks_on_row_order        (row_order)
#  index_tasks_on_title            (title)
#
# Foreign Keys
#
#  fk_rails_...  (assignee_id => users.id)
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (project_id => projects.id)
#

require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  let!(:member) { create(:user) }
  let!(:workspace) { create(:workspace, user: user, members: [member]) }
  let!(:project) { create(:project, workspace: workspace, users: [user]) }
  let!(:task1) { create(:task, title: 'deploy to heroku', project: project, due_date: (Date.today - 1), watchers: [user]) }
  let!(:task2) { create(:task, title: 'workspace', project: project, due_date: Date.today) }
  let!(:task3) { create(:task, title: 'deploy to digital oceane', project: project, assignee: user) }

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
      expect(member.available_tasks.search_tasks('deplo').count).to eq 2
      expect(member.available_tasks.search_tasks('worksp').count).to eq 1
      expect(member.available_tasks.search_tasks('iajshdkas').count).to eq 0
    end
  end

  describe '.this_week' do
    let!(:task4) { create(:task, created_at: (Date.today - 10), project: project) }
    let!(:task5) { create(:task, created_at: (Date.today - 10), project: project) }

    context 'it should take all tasks that was created this week' do
      it { (expect(project.tasks.this_week.count).to eq 3) }
    end
  end

  describe "notifications" do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:task) { create(:task,  project: project)}

    it "create message after user assigned to the task" do
      expect(user3.messages.count).to eq(0)
      task.add_watcher(user3)
      task.assign!(user1.id, user2)

      expect(task.assignee). to eq(user1)
      expect(user2.messages.count).to eq(0)
      expect(user3.messages.count).to eq(1)
      expect(task.assigned_by_id).to eq user2.id
    end

    it "create message after task completed" do
      expect(user2.messages.count).to eq(0)
      task.add_watcher(user1)
      task.add_watcher(user2)
      task.complete!(user1)

      expect(user1.messages.count).to eq(0)
      expect(user2.messages.count).to eq(1)
      expect(task.completed_by_id).to eq user1.id
    end
  end

  describe '.report' do
    let!(:completed_tasks){ create_list(:task, 5, project: project, completed_at: Date.today) }
    let!(:incompleted_tasks){ create_list(:task, 5, project: project) }

    it { expect(project.tasks.report).to eq({ complete: 5, incomplete: 8 }) }
  end

  describe '.users_report' do
    let!(:completed_tasks){ create_list(:task, 5, project: project, completed_at: Date.today, assignee: user, completed_by_id: user.id) }
    let!(:completed_tasks_by_member){ create_list(:task, 5, project: project, completed_at: Date.today, assignee: member, completed_by_id: member.id) }
    let!(:completed_tasks_without_assignee){ create_list(:task, 5, project: project, completed_at: Date.today, completed_by_id: user.id) }

    it { expect(project.tasks.users_report).to eq({ user.full_name => 10, member.full_name => 5 }) }
  end

  describe '.assignee?' do
    it { expect(task1.assignee?(user)).to eq false }
    it { expect(task3.assignee?(user)).to eq true }
  end

  describe '.expired?' do
    it { expect(task1.expired?).to eq true }
    it { expect(task2.expired?).to eq false }
  end

  describe '.remove_watcher' do
    it { expect{task1.remove_watcher(user)}.to change{ TaskWatch.count }.by(-1) }
  end
end
