require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views

  let!(:user_admin) { create(:user, role: 'admin') }
  let!(:user) { create(:user) }

  describe 'user'  do
    before do
      sign_in user_admin
    end

    context 'impersonate' do
      it 'it should impersonate admin as user' do
        post :impersonate, params: { id: user.id }
        expect(response).to redirect_to root_path
      end

      it 'should stop impersonating user' do
        post :stop_impersonating
        expect(response).to redirect_to root_path
      end
    end
  end
end
