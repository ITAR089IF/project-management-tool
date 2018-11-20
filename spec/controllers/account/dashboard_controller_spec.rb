require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace) }
  let!(:task1) { create(:task, :completed, project: project, watchers: [user]) }
  let!(:task2) { create(:task, project: project, watchers: [user]) }
  let!(:task3) { create(:task, project: project, watchers: [user]) }

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
      user.followed_tasks.each do |task|
        if task.start_time.present?
          page.should have_content(task.title)
        end
      end
    end
  end

  context 'GET /account/inbox' do
    it 'should return http status 200' do
      get :inbox
      expect(response).to have_http_status(200)
    end

    it 'show user completed tasks' do
      get :inbox
      # binding.pry
      # user.followed_tasks.complete.each do |task|
      expect(task1.title).to be

    end
  end
end
