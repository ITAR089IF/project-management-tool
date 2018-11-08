require 'rails_helper'

RSpec.describe Account::ProfilesController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:user_valid_params) { { first_name: "John"} }
  let!(:user_invalid_params) { { first_name: ""} }

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
      patch :update, params: { id: user.id, user: user_valid_params }
      user.reload
      expect(user.first_name).to eq(user_valid_params[:first_name])
    end

    it "should update the user's avatar" do
      patch :update, params: { id: user.id, user: user_valid_params }
      expect(user.avatar.attached?).to eq(false)
      user.avatar.attach(FileFactory.random_file)
      expect(user.avatar.attached?).to eq(true)
    end

    it "shouldn't update and redirects to 'edit'" do
      patch :update, params: { id: user.id, user: user_invalid_params }
      user.reload
      expect(user.first_name).to_not eq(user_invalid_params[:first_name])
      expect(response).to render_template(:edit)
    end
  end
end
