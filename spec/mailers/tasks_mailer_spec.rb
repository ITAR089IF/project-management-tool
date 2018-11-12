require "rails_helper"

RSpec.describe TasksMailer, type: :mailer do
<<<<<<< HEAD
  
=======
  describe "task_completed" do
    let!(:user) { create(:user) }
    let!(:current_user) { user }
    let!(:user1) { create(:user) }
    let!(:workspace) { create(:workspace, user: user) }
    let!(:project) { create(:project, workspace: workspace, users: [user]) }
    let!(:task1) { create(:task, project: project) }
    let!(:task) { create(:task, watchers: [user1]) }
    let!(:mail) { TasksMailer.task_completed(@task, current_user) }

    it 'renders the subject' do
      expect(mail.subject).to eql("Task completed")
    end

    it 'renders the sender email' do
      expect(mail.from).to eql('info@asana.com')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(task.watchers.first.email)
    end

    it 'assigns @title' do
      expect(mail.body.encoded).to include(task.title)
    end

  end
>>>>>>> 08a0a9b5ccbbd749cf110488f1240524188121ac
end
