require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views

  let!(:user_admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  describe 'admin impersonate'  do
    context 'impersonate' do
      before do
        sign_in user_admin
      end

      it 'it should impersonate admin as user' do
        expect(controller.current_user).to eq user_admin

        post :impersonate, params: { id: user.id }

        expect(controller.current_user).to eq user
        expect(controller.true_user).to eq user_admin
        expect(response).to redirect_to root_path
      end
    end

    context 'stop_impersonate' do
      before do
        sign_in user_admin
        post :impersonate, params: { id: user.id }
      end

      it 'should stop impersonating user' do
        post :stop_impersonating

        expect(response).to redirect_to root_path
        expect(controller.current_user).to eq user_admin
        expect(controller.true_user).to eq user_admin
      end
    end
  end
end
