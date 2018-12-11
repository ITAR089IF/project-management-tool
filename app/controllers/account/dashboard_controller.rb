class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
  end

  def tasks_info_card
  end

  def tasks_info
    @incomplete = current_user.assigned_tasks.incomplete
    @due_soon = @incomplete.due_soon.count
    @outdated = @incomplete.outdated.count
    @incomplete = @incomplete.count
    render json: { incomplete: @incomplete, due_soon: @due_soon, outdated: @outdated }
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
