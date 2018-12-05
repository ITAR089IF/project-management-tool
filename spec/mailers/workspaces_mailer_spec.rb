require "rails_helper"

RSpec.describe WorkspacesMailer, type: :mailer do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:file) { WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>') }
  let!(:mail) { WorkspacesMailer.workspace_details(workspace, user, file) }
  
  describe "workspace mailer" do

    it 'send details to email' do
      ActiveJob::Base.queue_adapter = :test
      expect {WorkspacesMailer.workspace_details(workspace, user, file).deliver_later}.to have_enqueued_job.on_queue('mailers')
    end

    it 'email subject' do
      expect(mail.subject).to eq("You have been received workspace details")
    end

  end
end
