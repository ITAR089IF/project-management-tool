# Preview all emails at http://localhost:3000/rails/mailers/tasks_mailer
class TasksMailerPreview < ActionMailer::Preview
  def task_assign_to_user_email
    task = Task.last
    TasksMailer.task_assign_to_user_email(task)
  end
end
