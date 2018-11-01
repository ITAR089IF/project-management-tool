require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  context 'GET /account/dashboard' do
    it 'should show index page' do
      get :index
      expect(response).to be_successful
    end
  end
end
