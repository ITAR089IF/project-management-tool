class TasksMailer < ApplicationMailer
  def task_assign_to_user_email(task)
    @task = task
    @user = User.find_by(id: task.assignee_id)
    mail(to: @user.email, subject: 'Task detail')
  end
end
