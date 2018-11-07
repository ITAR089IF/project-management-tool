class TasksMailer < ApplicationMailer
  default from: "info@asana.com"
  default template_path: 'mailers/tasks'

  def task_completed(watcher, task, user)
    @task = task
    @user = user
    mail(
        to: watcher.email ,
        subject: "Task compileted"
      )
  end
end
