require 'rails_helper'

RSpec.describe WorkspaceDetailsJob, type: :job do
  let!(:user) { create(:user) }
  let!(:workspace) { create(:workspace, user: user) }
  let!(:file) { WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>') }

  it "get a details" do
    ActiveJob::Base.queue_adapter = :test
    expect { WorkspaceDetailsJob.perform_later(workspace.id, user.id) }.to have_enqueued_job
  end

  it "check if mailer calls" do
    mail = double
    expect(mail).to receive(:deliver_later)
    expect(WorkspacesMailer).to receive(:workspace_details).and_return(mail)
    WorkspaceDetailsJob.perform_now(workspace.id, user.id)
  end
end