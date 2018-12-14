class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
  end

  def top_workspaces
    @top_workspaces = []
    current_user.available_workspaces.each do |workspace|
      @incomplete = workspace.tasks.incomplete.count
      @complete = workspace.tasks.complete.count
      @top_workspaces.push({name: workspace.name, uncompleted: @incomplete, completed: @complete})
      @top_workspaces.sort_by! { |k| k[:completed] }.reverse!
      @top_five_workspaces = @top_workspaces.first(5)
    end

    render json: @top_five_workspaces
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

  def top_users_card
  end

  def change_messages_read
    current_user.messages.unreaded.update_all(is_read: true)
  end
end
