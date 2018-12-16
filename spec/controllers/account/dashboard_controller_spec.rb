require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  render_views

  let!(:user) { create(:user, first_name: "John", last_name: "Doe") }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace) }
  let!(:task1) { create(:task, :completed, project: project, watchers: [user], title: "task1") }
  let!(:message) { create(:message, messageable: task1, user: user, body: "#{task1.title} has been completed by #{user.full_name}") }
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

  context 'GET /account/user_info' do
    it 'should show index page' do
      get :user_info, as: :json
      expect(response.body).to include("info")
      expect(response).to have_http_status(200)
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

    it "show user inbox with message" do
      get :index
      expect(user.messages.first.body).to eq("task1 has been completed by John Doe")
    end
  end
end
