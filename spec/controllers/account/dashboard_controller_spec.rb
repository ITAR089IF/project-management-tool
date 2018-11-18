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

  context 'GET /account/calendar' do
    it 'should return http status 200' do
      get :calendar
      expect(response).to have_http_status(200)
    end

    it 'show user task' do
      get :calendar
      user.tasks.each do |task|
        if task.start_time.present?
          page.should have_content(task.title)
        end
      end
    end
  end
end
