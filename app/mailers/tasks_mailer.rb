class TasksMailer < ApplicationMailer
  default from: "info@asana.com"

  def task_assign_to_user_email(task)
    @task = task
    @user = @task.assignee
    mail(to: @user.email, subject: 'Task detail')
  end
end
