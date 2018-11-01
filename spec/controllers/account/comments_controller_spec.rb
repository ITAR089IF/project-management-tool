require 'rails_helper'

RSpec.describe Account::CommentsController, type: :controller do
  render_views

  let!(:project) { create(:project) }
  let!(:task) { create(:task, project: project) }
  let!(:user) { create(:user) }
  let!(:comment_for_task) { create(:comment, :for_task, body: 'Body', user: user, commentable: task) }
  let!(:comment_for_project) { create(:comment, :for_project, body: 'Body', user: user, commentable: project) }
  let(:projects_comment_params) do
      { comment: { body: 'Body'}, project_id: project.id, format: :js }
  end
  let(:tasks_comment_params) do
    { comment: { body: 'Body'}, task_id: task.id, format: :js }
  end
  let(:invalid_params_for_projects_comment) do
    { comment: { body: ''}, project_id: project.id, format: :js }
  end
  let(:invalid_params_for_tasks_comment) do
    { comment: { body: ''}, task_id: task.id, format: :js }
  end

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'comment for project' do
      context 'success' do
        subject { post :create, params: projects_comment_params }

        it 'creates comment' do
          expect{ subject }.to change{ user.comments.count }.by 1
        end
      end

      context 'fail' do
        subject { post :create, params: invalid_params_for_projects_comment }

        it 'comment was not created' do
          expect{ subject }.not_to change{ user.comments.count }
        end
      end
    end

    context 'comment fot task' do
      subject { post :create, params: tasks_comment_params }

      context 'success' do
        it 'creates comment' do
          expect{ subject }.to change{ user.comments.count }.by 1
        end
      end

      context 'fail' do
        subject { post :create, params: invalid_params_for_tasks_comment }

        it 'comment was not created' do
          expect{ subject }.not_to change{ user.comments.count }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: comment_for_project.id, project_id: projec.id, format: :js} }
    context 'delete projects comment' do
      it { expect{ subject }.to change{ user.comments.count }.by -1 }
    end

    subject { delete :destroy, params: { id: comment_for_task.id, task_id: task.id, format: :js } }
    context 'delete tasks comment' do
      it { expect{ subject }.to change{ user.comments.count }.by -1 }
    end
  end
end
