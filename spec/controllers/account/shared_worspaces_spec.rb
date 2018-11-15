require 'rails_helper'

RSpec.describe Account::SharedWorkspacesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:workspace1) { create(:workspace, user: user1) }
  let!(:shared_workspace) { create(:shared_workspace, user: user, workspace: workspace1) }
  let!(:shared_workspace1) { create(:shared_workspace, user: user2, workspace: workspace1) }

  before { sign_in user }

  context '#GET /new' do
    it 'renders form' do
      get :new, params: { id: workspace.id },
        format: :js, xhr: true
      expect(response).to render_template :new
    end
  end

  context '#POST /create' do
    subject { post :create, params: { workspace: { user_id: user3.id }, id: workspace.id }, format: :js, xhr: true }
    it 'addes new member to workspace' do
      expect{ subject }.to change{ workspace.members.reload.count }.from(0).to(1)
      expect(response).to render_template :create
    end
  end

  context 'DELETE /destroy' do
    context 'removes current user from workspace' do
      subject { delete :destroy, params: { user_id: user.id, id: workspace1.id  } }
      it do
        expect{ subject }.to change{ workspace1.members.count}.from(2).to(1)
        expect(response).to redirect_to account_workspaces_path
      end
    end

    context 'removes another user from workspace' do
      subject { delete :destroy, params: { user_id: user2.id, id: workspace1.id }, format: :js }
      it do
        expect{ subject }.to change{ workspace1.members.count}.from(2).to(1)
        expect(response).to render_template :destroy
      end
    end
  end
end
