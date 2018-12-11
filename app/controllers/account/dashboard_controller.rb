class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
  end

  def tasks_info_card
  end

  def tasks_info
    @task_info = {}
    current_user.available_workspaces.each do |workspace|
      @incomplete = workspace.tasks.assigned_to(current_user).incomplete
      @due_soon = @incomplete.due_soon.count
      @outdated = @incomplete.outdated.count
      @incomplete = @incomplete.count
      @task_info[workspace.name] = {incomplete: @incomplete, due_soon: @due_soon, outdated: @outdated}
    end

    render json: @task_info
  end

  def calendar
    @user_tasks = current_user.followed_tasks
  end

  def inbox
    @new_messages = current_user.messages.unreaded.newest
    @old_messages = current_user.messages.readed.newest
    @old_messages = @old_messages.page(params[:page]).per(20)
  end

  def change_messages_read
    current_user.messages.unreaded.update_all(is_read: true)
  end
end
