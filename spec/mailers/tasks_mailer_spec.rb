require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe TasksMailer, type: :mailer do

  let!(:user) { create(:user) }
  let!(:current_user) { user }
  let!(:user1) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:project) { create(:project, workspace: workspace, users: [user]) }
  let!(:task1) { create(:task, project: project) }
  let!(:task) { create(:task, watchers: [user1, user]) }
  let!(:task2) { create(:task, assignee: user) }

  describe "task_completed" do

    it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        TasksMailer.task_completed(task, current_user).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it 'welcome_email is sent' do
      expect {
        perform_enqueued_jobs do
          TasksMailer.task_completed(task, current_user).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'email is sent to the right user' do
      perform_enqueued_jobs do
        TasksMailer.task_completed(task, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user1.email
    end

    it 'email subject' do
      perform_enqueued_jobs do
        TasksMailer.task_completed(task, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eql("Task completed")
    end

    it 'email title' do
      perform_enqueued_jobs do
        TasksMailer.task_completed(task, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body.encoded).to include(task.title)
    end
  end

  describe "task_assign_to_user_email" do

    it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        TasksMailer.task_assign_to_user_email(task2).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it 'welcome_email is sent' do
      expect {
        perform_enqueued_jobs do
          TasksMailer.task_assign_to_user_email(task2).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'email is sent to the right user' do
      perform_enqueued_jobs do
        TasksMailer.task_assign_to_user_email(task2).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq user.email
    end

    it 'email subject' do
      perform_enqueued_jobs do
        TasksMailer.task_assign_to_user_email(task2).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eql("New Assignment")
    end

    it 'email title' do
      perform_enqueued_jobs do
        TasksMailer.task_assign_to_user_email(task2).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body.encoded).to include(task2.title)
    end
  end
end
