require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #edit" do
    it "must display edit page" do
      get :edit, params: { user_id: user.to_param, id: user.to_param }
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT #update" do
    it "should update the user's name" do
      patch :update, params: { id: user.id, user: { first_name: "John" } }
      expect(controller.notice).to eq('Profile successfully updated!')
    end

    it "shouldn't update and redirects to 'edit'" do
      patch :update, params: { id: user.id, user: { first_name: "" } }
      expect(controller.notice).not_to eq('Profile successfully updated!')
      expect(response).to render_template("account/users/edit")
    end
  end
end
