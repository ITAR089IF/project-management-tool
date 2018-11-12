require 'rails_helper'

RSpec.describe Account::TasksController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace, users: [user, user1]) }
  let!(:task1) { create(:task, project: project) }
  let!(:task2) { create(:task, project: project, watchers: [user1, user2, user3, user4]) }
  let!(:task3) { create(:task, project: project) }

  before do
    sign_in user
  end

  context 'GET /projects/:project_id/task/:id' do
    it 'should show task page' do
      get :show, params: { project_id: project.id, id: task1.id }
      expect(response).to be_successful
    end
  end

  context 'GET /projects/:project_id/task/new' do
    it 'should show new task page' do
      get :new, params: { project_id: project.id }
      expect(response).to be_successful
    end
  end

  context 'POST /projects/:project_id/tasks' do
    it 'should create task' do
      post :create, params: {
        project_id: project.id,
        task: {
          title: Faker::Lorem.sentence,
          description: Faker::Lorem.paragraph
        }
      }

      expect{ post :create, params: { project_id: project.id, task: { title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph }}}.to change(Task, :count).by(1)
    end
  end

  context 'DELETE/projects/:project_id/tasks/:id' do
    it 'should delete task with :js' do
      expect(project.tasks.count).to eq 3
      delete :destroy, params: { project_id: project.id, id: task1.id }, format: :js
      expect(project.tasks.count).to eq 2
    end

    it 'should delete task with :html' do
      delete :destroy, params: {
        project_id: project.id, id: task2.id
      }
      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
    end
  end

  context 'PATCH /:complete' do
    it 'should change status of the task' do
      expect(project.tasks.complete.count).to eq 0
      patch :complete, params: { project_id: project.id, id: task1.id }, format: :js
      expect(project.tasks.complete.count).to eq 1
    end
  end

  context 'PUT /:move' do
    it 'should move task down' do
      put :move, params: {
        project_id: project.id,
        id: project.tasks.first.id,
        task: {
          row_order_position: :down
        }
      }

      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
      expect(project.tasks.row_order_asc).to eq [task2, task1, task3]
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
      expect(project.tasks.row_order_asc).to eq [task1, task3, task2]
    end
  end

  context 'POST /watch' do
    it 'should follow task if no one follow yet' do
      expect(task1.watchers.count).to eq 0

      patch :watch, params: { project_id: project.id, id: task1.id }, format: :js

      task1.reload

      expect(task1.watchers.count).to eq 1
      expect(task1.watchers).to include user
    end

    it 'should follow task if some one follow task already' do
      expect(task2.watchers.count).to eq 4

      patch :watch, params: { project_id: project.id, id: task2.id }, format: :js

      task2.reload

      expect(task2.watchers.count).to eq 5
      expect(task2.watchers).to include user
    end

    it 'should unfollow task' do
      sign_in user1
      expect(task2.watchers.count).to eq 4

      patch :watch, params: { project_id: project.id, id: task2.id }, format: :js

      task2.reload
      expect(task2.watchers.count).to eq 3
      expect(task2.watchers).to_not include user1
    end
  end

  context "DELETE /:delete_file_attachment" do
    let!(:task)       { create(:task, :with_files, project: project) }
    let!(:attachment) { task.files.last }

    it "must remove attachment fromm a task" do
      delete :remove_attachment, params: { project_id: project.id, id: task.id, attachment_id: attachment.id}

      expect(response).to redirect_to(account_project_task_path(project.id, task.id))
    end
  end

  context '#GET /choose_assignee' do
    it 'renders assignee form' do
      get :choose_assignee, params: { project_id: project.id, id: task1.id },
        format: :js, xhr: true
      expect(response).to render_template :choose_assignee
    end
  end

  context '#POST /assign' do
    it 'initial assign' do
      post :assign, params: { task: { assignee: user1.id }, id: task1.id, project_id: project.id }, format: :js, xhr: true
      task1.reload
      expect(response).to render_template :assign
      expect(task1.assignee).to eql user1
    end
    it 'reassign' do
      post :assign, params: { task: { assignee: user1.id }, id: task2.id, project_id: project.id }, format: :js, xhr: true
      task2.reload
      expect(response).to render_template :assign
      expect(task2.assignee).to eql user1
    end
  end

  context '#DELETE /unassign' do
    it 'delete assignee for task'  do
      delete :unassign, params: { project_id: project.id, id: task2.id }, format: :js
      expect(task2.reload.assignee).to be_nil
      expect(response).to render_template :unassign
    end
  end

  describe 'GET /tasks/search' do
    it 'should return search result in format json' do
      get :search, params: { search: 'Text' }
      expect(response).to be_successful
    end
  end
end
