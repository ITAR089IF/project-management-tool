require "rails_helper"

RSpec.describe TasksMailer, type: :mailer do
  describe "tasks_completed" do
    let!(:mail) { TasksMailer.tasks_completed }

    it "renders the headers" do
      expect(mail.subject).to eq("Task compileted")
      expect(mail.from).to eq(["info@asana.com"])
    end
  end
end
