require "rails_helper"

RSpec.describe TasksMailer, type: :mailer do
  describe "task_assign_to_user_email" do
    let!(:mail) { TasksMailer.task_assign_to_user_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Task detail")
      expect(mail.from).to eq(["info@asana.com"])
    end
  end
end
