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
  let!(:shared_workspace1) { create(:shared_workspace, user: user1, workspace: workspace) }
  let!(:shared_workspace2) { create(:shared_workspace, user: user2, workspace: workspace) }
  let!(:shared_workspace3) { create(:shared_workspace, user: user3, workspace: workspace) }
  let!(:shared_workspace4) { create(:shared_workspace, user: user4, workspace: workspace) }
  let!(:task1) { create(:task, project: project) }
  let!(:task2) { create(:task, project: project, watchers: [user1, user2, user3, user4]) }
  let!(:task3) { create(:task, :completed, project: project) }
  let!(:task_valid_params) { { title: "test_task"} }
  let!(:task_invalid_params) { { title: nil} }

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

    it 'should add current_user to watchers tasks' do
      post :create, params: {
        project_id: project.id,
        task: {
          title: Faker::Lorem.sentence
        }
      }
      expect{ post :create, params: { project_id: project.id, task: { title: Faker::Lorem.sentence }}}.to change(user.followed_tasks, :count).by(1)
    end
  end

  describe "GET #edit" do
    it "must display edit page" do
      get :edit, params: { project_id: project.id, id: task1.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "must update the project" do
        put :update, params: { project_id: project.id, id: task1.id, task: task_valid_params}
        task1.reload
        expect(task1.title).to eq(task_valid_params[:title])
      end
    end

    context "with invalid attributes" do
      it "must not update the project and render 'edit' form" do
        put :update, params: { project_id: project.id, id: task1.id, task: task_invalid_params}
        task1.reload
        expect(task1.title).not_to eq(task_invalid_params[:title])
        expect(response).to render_template("account/tasks/_form")
      end
    end
  end


  context 'DELETE/projects/:project_id/tasks/:id' do
    it 'should delete task with :js' do
      expect(project.tasks.count).to eq 3
      delete :destroy, params: { project_id: project.id, id: task1.id }, format: :js
      expect(project.tasks.count).to eq 2
      expect(project.tasks.with_deleted.count).to eq 3
    end

    it 'should delete task with :html' do
      delete :destroy, params: {
        project_id: project.id, id: task2.id
      }
      expect(response).to redirect_to account_workspace_project_path(workspace.id, project.id)
    end
  end

  context 'PATCH /:toggle_complete' do
    it 'marks task as completed' do
      expect(project.tasks.complete.count).to eq 1
      patch :toggle_complete, params: { project_id: project.id, id: task1.id }, format: :js

      expect(project.tasks.complete.count).to eq 2
      expect(task1.reload.completed_by_id).to eq user.id
    end
  end

  context 'PATCH /:toggle_complete' do
    it 'marks task as uncompleted' do
      expect(project.tasks.complete.count).to eq 1
      patch :toggle_complete, params: { project_id: project.id, id: task3.id }, format: :js

      expect(project.tasks.complete.count).to eq 0
      expect(task3.completed_by_id).to eq nil
    end
  end

  context 'GET /projects/:project_id/edit' do
    it { expect(get :edit, params: { project_id: project.id, id: task1.id }).to be_successful }
  end

  context 'PUT /perojecs/:project_id/tasks/:id' do
    it 'should update task' do
      put :update, params: {
        project_id: project.id,
        id: task1.id,
        task: {
          title: 'Some text'
        }
      }

      task1.reload

      expect(response).to redirect_to account_project_task_path(project, task1)
      expect(task1.title).to eq 'Some text'
    end
  end

  context 'PATCH /:move' do
    it 'should move task down' do
      patch :move, params: {
        project_id: project.id,
        id: project.tasks.first.id,
        move: {
          move_option: :down,
          move_positions: 2
        }
      },
      format: :js

      expect(response).to render_template :move
      expect(project.tasks.row_order_asc).to eq [task2, task3, task1]
    end

    it 'should move task up' do
      patch :move, params: {
        project_id: project.id,
        id: project.tasks.last.id,
        move: {
          move_option: :up,
          move_positions: 2
        }
      },
      format: :js

      expect(response).to render_template :move
      expect(project.tasks.row_order_asc).to eq [task3, task1, task2]
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
      expect(task1.assigned_by_id).to eq user.id
    end

    it 'reassign' do
      post :assign, params: { task: { assignee: user1.id }, id: task2.id, project_id: project.id }, format: :js, xhr: true
      task2.reload
      expect(response).to render_template :assign
      expect(task2.assignee).to eql user1
      expect(task2.assigned_by_id).to eq user.id
    end

    it 'assignee user start follow task' do
      post :assign, params: { task: { assignee: user1.id }, id: task1.id, project_id: project.id }, format: :js, xhr: true
      task1.reload
      expect(task1.watchers).to include(task1.assignee)
    end
  end

  context '#DELETE /unassign' do
    it 'delete assignee for task'  do
      delete :unassign, params: { project_id: project.id, id: task2.id }, format: :js
      expect(task2.reload.assignee).to be_nil
      expect(task2.reload.assigned_by_id).to be_nil
      expect(response).to render_template :unassign
    end
  end

  describe '#REPORT /project/project_id/tasks' do
    it 'it should be success' do
      get :report, params: { project_id: project.id }, format: :pdf
      expect(response).to be_successful
    end
  end
end
