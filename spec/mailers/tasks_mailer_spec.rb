require "rails_helper"

RSpec.describe TasksMailer, type: :mailer do
  describe "task_completed" do
    let!(:user) { create(:user) }
    let!(:current_user) {user}
    let!(:user1) { create(:user) }
    let!(:task) { create(:task, watchers: [user1]) }
    let!(:mail) { TasksMailer.task_completed(@task, current_user) }

    it 'renders the subject' do
      expect(mail.subject).to eql("Task completed")
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['info@asana.com'])
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([task.watchers.first.email])
    end

    it 'assigns @title' do
      expect(mail.body.encoded).to match(task.title)
    end

  end
end
