require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views

  let!(:user_admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:user_valid_params) { { first_name: "John" } }
  let!(:user_invalid_params) { { first_name: "" } }

  describe '#impersonate'  do
    context 'impersonate admin as user' do
      before do
        sign_in user_admin
      end

      it 'should impersonate admin as user' do
        expect(controller.current_user).to eq user_admin

        post :impersonate, params: { id: user.id }

        expect(controller.current_user).to eq user
        expect(controller.true_user).to eq user_admin
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#stop_impersonating' do
    context 'stop impersonate user' do
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

  describe "GET #index" do
    before do
      sign_in user_admin
    end

    it 'should show all users' do
      get :index
      expect(response).to be_successful
    end

    describe 'GET #show' do
      it 'should show user page' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
        expect(response).to be_successful
      end
    end

    describe 'GET #edit' do
      it 'must display edit page' do
        get :edit, params: { id: user.id }
        expect(response).to render_template(:edit)
      end

      describe 'PUT #update' do
        context 'with valid attributes' do
          it 'must update the user' do
            patch :update, params: { id: user.id, user: user_valid_params }
            user.reload
            expect(user.first_name).to eq(user_valid_params[:first_name])
          end
        end

        context 'with invalid attributes' do
          it 'shouldnt update and redirects to edit' do
            patch :update, params: { id: user.id, user: user_invalid_params }
            user.reload
            expect(user.first_name).not_to eq(user_valid_params[:first_name])
            expect(response).to render_template(:edit)
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'should delete user' do
          expect{ (delete :destroy, params: { id: user.id }) }.to change{ User.count }.by(-1)
          expect(response).to redirect_to admin_users_path
        end
      end
    end
  end
end