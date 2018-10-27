require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:project) { create :project }
  let(:task) { create :task, project: project }
  let(:current_user) { create :user }
  let(:params) do
    { comment: { body: 'Body', commentable_type: project.class.name,
                 commentable_id: project.id  } }
  end

  before { allow(controller).to receive(:current_user).and_return(current_user) }

  subject { post :create, params: params }

  describe 'POST #create' do
    context 'comment for project' do
      context 'success' do
        it 'creates comment' do
          expect(response.status).to eq 200
          expect{subject}.to change{ Comment.count }.by 1
        end
      end

      context 'fail' do
        let(:params) do
          { comment: { body: '', commentable_type: project.class.name,
                       commentable_id: project.id  } }
        end
        it 'comment was not created' do
          expect(response.status).to eq 200
          expect{subject}.not_to change{ Comment.count }
        end
      end
    end

    context 'comment fot task' do
      let(:params) do
        { comment: { body: 'Body', commentable_type: task.class.name,
                     commentable_id: task.id  } }
      end
      context 'success' do
        it 'creates comment' do
          expect(response.status).to eq 200
          expect{subject}.to change{ Comment.count }.by 1
        end
      end

      context 'fail' do
        let(:params) do
          { comment: { body: '', commentable_type: task.class.name,
                       commentable_id: task.id  } }
        end
        it 'comment was not created' do
          expect(response.status).to eq 200
          expect{subject}.not_to change{ Comment.count }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: comment.id } }

    context 'delete projects comment' do
      let!(:comment) {create :project_comment, commentable: project, user: current_user}

      it { expect{subject}.to change{ Comment.count }.by -1 }
    end

    context 'delete tasks comment' do
      let!(:comment) {create :task_comment, commentable: task, user: current_user}
      
      it { expect{subject}.to change{ Comment.count }.by -1 }
    end
  end
end
