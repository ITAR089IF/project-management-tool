class TasksMailer < ApplicationMailer
  default template_path: 'mailers/tasks'

  def task_completed(task, current_user)
    @task = task
    @user = current_user
    email_watchers = @task.watchers.where.not(users: {id: @user.id}).pluck(:email)
    mail(
      to: email_watchers,
      subject: "Task completed"
    )
  end
end
