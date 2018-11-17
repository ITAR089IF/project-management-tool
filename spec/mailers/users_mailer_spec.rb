require "rails_helper"

RSpec.describe UsersMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:current_user) { create(:user) }
  
  describe "New user registration" do
    it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        UsersMailer.send_new_user_message(current_user).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it 'registration_email is sent' do
      expect {
        perform_enqueued_jobs do
          UsersMailer.send_new_user_message(current_user).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'email is sent to the admins' do
      perform_enqueued_jobs do
        UsersMailer.send_new_user_message(current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq admins.email
    end

    it 'email subject' do
      perform_enqueued_jobs do
        UsersMailer.send_new_user_message(current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eql("New user registration")
    end
  end
end
