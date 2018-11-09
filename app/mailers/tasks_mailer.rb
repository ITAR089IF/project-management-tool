class TasksMailer < ApplicationMailer
  default template_path: 'mailers/tasks'

  def task_completed(task, current_user)
    @task = task
    @user = current_user
    mail(
      to: @task.watchers.map {|watcher| watcher.email if watcher != current_user},
      subject: "Task completed"
    )
  end
end
