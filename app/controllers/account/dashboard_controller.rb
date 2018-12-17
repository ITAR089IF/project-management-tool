class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
    @user_layout = current_user.dashboard_layout
  end

  def top_workspaces
    render json: { info: TopWorkspaces.new(current_user).report }
  end

  def user_info
    render json: { info: UserInfo.new(current_user).report }
  end

  def tasks_info
    render json: { info: TaskInfo.new(current_user, params[:id]).report,
                  workspaces: WorkspacesReport.new(current_user).report }
  end

  def comments_info
    render json: { info: CommentsInfo.new(current_user).report }
  end

  def calendar
    @user_tasks = current_user.followed_tasks
  end

  def inbox
    @new_messages = current_user.messages.unreaded.newest
    @old_messages = current_user.messages.readed.newest
    @old_messages = @old_messages.page(params[:page]).per(20)
  end

  def top_users_card
  end

  def change_messages_read
    current_user.messages.unreaded.update_all(is_read: true)
  end
end
