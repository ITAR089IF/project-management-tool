class TasksMailer < ApplicationMailer
  default from: "info@asana.com"
  default template_path: 'mailers/tasks'

  def task_completed(watcher, task, current_user)
    @task = task
    @user = current_user
    mail(
        to: watcher.email ,
        subject: "Task compileted"
      )
  end
end
