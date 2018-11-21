require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe MembersMailer, type: :mailer do

  let!(:current_user) { create(:user) }
  let!(:member) { create(:user) }
  let!(:workspace) { create(:workspace, user: current_user) }

  describe "member added" do

    it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        MembersMailer.member_added(member, workspace, current_user).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it 'welcome_email is sent' do
      expect {
        perform_enqueued_jobs do
          MembersMailer.member_added(member, workspace, current_user).deliver_later
        end
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'email is sent to the right user' do
      perform_enqueued_jobs do
        MembersMailer.member_added(member, workspace, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to[0]).to eq member.email
    end

    it 'email subject' do
      perform_enqueued_jobs do
        MembersMailer.member_added(member, workspace, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eql("You have been added to the workspace")
    end

    it 'email title' do
      perform_enqueued_jobs do
        MembersMailer.member_added(member, workspace, current_user).deliver_later
      end
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body.encoded).to include(workspace.name)
    end
  end
end
