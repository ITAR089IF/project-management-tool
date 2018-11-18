require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe 'GET dashboard' do
    it 'should get index page' do
      get :index
      expect(response).to be_successful
    end

    it 'should get index page' do
      get :product
      expect(response).to be_successful
    end

    it 'should get index page' do
      get :pricing
      expect(response).to be_successful
    end
  end
end
