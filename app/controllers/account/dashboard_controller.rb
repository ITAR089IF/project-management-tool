class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
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
    @top_users = []
    @workspaces = current_user.available_workspaces
    @collection = @workspaces.find(params[:id]).all_members
    @workspace = @workspaces.find(params[:id])
    @collection.each do |member|
      name = member.full_name
      completed = @workspace.tasks.complete_by(member).count
      @top_users.push( name: name, completed:completed)
    end
    @top_users = @top_users.sort_by{ |k| -k[:completed]}
    @top_five_users = @top_users[0..4]

    @workspaces = @workspaces.pluck(:id, :name).to_h
    render json: { info: @top_five_users,  workspaces: @workspaces }

  end

  def change_messages_read
    current_user.messages.unreaded.update_all(is_read: true)
  end
end
