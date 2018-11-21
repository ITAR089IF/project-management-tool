require 'rails_helper'

RSpec.describe Account::MembersController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:workspace1) { create(:workspace, user: user1) }
  let!(:workspace2) { create(:workspace, user: user) }
  let!(:shared_workspace) { create(:shared_workspace, user: user, workspace: workspace1) }
  let!(:shared_workspace1) { create(:shared_workspace, user: user2, workspace: workspace1) }
  let!(:invitation) { create(:invitation, invitor: user, workspace: workspace, created_at:  1.days.ago) }
  let!(:outdated_invitation) { create(:invitation, invitor: user, workspace: workspace, token: '1', created_at: 150.days.ago) }


  before { sign_in user }

  context '#GET /new' do
    it 'renders form' do
      get :new, params: { workspace_id: workspace.id },
        format: :js, xhr: true
      expect(response).to render_template :new
    end
  end

  context '#POST /create' do
    subject { post :create, params: { shared_workspace: { user_id: user3.id }, workspace_id: workspace.id }, format: :js, xhr: true }
    it 'addes new member to workspace' do
      expect{ subject }.to change{ workspace.members.reload.count }.from(0).to(1)
      expect(response).to render_template :create
    end
  end

  context 'DELETE /destroy' do
    context 'removes current user from workspace' do
      subject { delete :destroy, params: { id: user.id, workspace_id: workspace1.id  } }

      it do
        expect{ subject }.to change{ workspace1.members.count}.from(2).to(1)
        expect(response).to redirect_to account_workspaces_path
      end
    end

    context 'removes another user from workspace' do
      subject { delete :destroy, params: { id: user2.id, workspace_id: workspace1.id }, format: :js }

      it do
        expect{ subject }.to change{ workspace1.members.count}.from(2).to(1)
        expect(response).to render_template :destroy
      end
    end
  end

  context 'GET /greeting_new_member' do
    context 'invalid token' do
      subject do
        get :greeting_new_member, params: { workspace_id: workspace.id,
                                            token: 'wrong_token1234567890' }
      end

      it do
        subject

        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq('Sorry, could not identify following link')
      end
    end

    context 'outdated link' do
      subject do
        get :greeting_new_member, params: { invitor_id: user.id,
                                            workspace_id: workspace.id,
                                            token: '1' }
      end

      it do
        subject

        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq('Sorry, this link is no longer valid')
      end
    end

    context 'user already in workspace' do
      subject do
        get :greeting_new_member, params: { invitor_id: user.id,
                                            workspace_id: workspace.id,
                                            token: invitation.token }
      end

      it 'does not create new member' do
        subject

        expect(response).to render_template :greeting_new_member
        expect(response.body).to match(/You are already a member/)
      end
    end

    context 'user is new member' do
      let!(:workspace) { create(:workspace, user: user1) }

      subject do
        get :greeting_new_member, params: { invitor_id: user1.id,
                                            workspace_id: workspace.id,
                                            token: invitation.token }
      end

      it 'redirects to create_thought_link' do
        subject
        expect(response).to render_template :greeting_new_member
        expect(response.body).to match(/You have invited by #{user.full_name}. To continue, follow the link:/)
      end
    end
  end

  context 'POST #create_thought_link' do
    subject { post :create_thought_link, params: { workspace_id: workspace2.id, user_id: user3.id } }

    it { expect{ subject }.to change(workspace2.members.reload, :count).by(1) }
  end
end
