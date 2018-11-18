require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe 'GET dashboard' do
    it 'should get index page' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should get index page' do
      get :product
      expect(response).to have_http_status(:ok)
    end

    it 'should get index page' do
      get :pricing
      expect(response).to have_http_status(:ok)
    end
  end
end
