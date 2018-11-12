require 'rails_helper'

RSpec.describe Account::ProfilesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:user_valid_params) { { first_name: "John" } }
  let!(:user_invalid_params) { { first_name: "" } }
  let!(:file) { fixture_file_upload('spec/fixtures/files/asana.png') }

  before do
    sign_in user
  end

  describe "GET #edit" do
    it "must display edit page" do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    it "should update the user's name" do
      patch :update, params: { id: user.id, user: user_valid_params}
      user.reload
      expect(user.first_name).to eq(user_valid_params[:first_name])
    end

    it "shouldn't update and redirects to 'edit'" do
      patch :update, params: { id: user.id, user: user_invalid_params }
      user.reload
      expect(user.first_name).to_not eq(user_invalid_params[:first_name])
      expect(response).to render_template(:edit)
    end

    it "should update the user's avatar" do
      patch :update, params: { id: user.id, user: { avatar: file } }
      user.reload
      expect(user.avatar.attached?).to be
    end
  end
end
