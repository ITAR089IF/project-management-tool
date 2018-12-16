class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
    @user_layout = current_user.dashboard_layout
  end

  def top_workspaces_card

  end

  def user_info_card
  end

  def tasks_info_card

  end

  def calendar
    @user_tasks = current_user.followed_tasks
  end

  def inbox
    @new_messages = current_user.messages.unreaded.newest
    @old_messages = current_user.messages.readed.newest
    @old_messages = @old_messages.page(params[:page]).per(20)
  end

  def top_users
    render json: { info: TopUsers.new(current_user, params[:id]).report,
                   workspaces: WorkspacesReport.new(current_user).report }

  end

  def change_messages_read
    current_user.messages.unreaded.update_all(is_read: true)
  end
end
