class TasksMailer < ApplicationMailer
  default template_path: 'mailers/tasks'

  def task_completed(task, current_user)
    @task = task
    @user = current_user
    watchers = @task.watchers.map {|watcher| watcher.email if watcher != current_user}
    if watchers.present?
      mail(
        to: watchers,
        subject: "Task completed"
      )
    end
  end
end
