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

  def tasks_info
    @task_info = []
    @workspaces = current_user.available_workspaces
    if params[:id]
      @collection = @workspaces.find(params[:id]).projects
    else
      @collection = @workspaces
    end
    @collection.each do |item|
      @incomplete = item.tasks.assigned_to(current_user).incomplete
      @due_soon = @incomplete.due_soon.count
      @outdated = @incomplete.outdated.count
      @incomplete = @incomplete.count
      @task_info.push({name: item.name, uncompleted: @incomplete, 'due soon' => @due_soon, outdated: @outdated})
    end
    @workspaces = @workspaces.pluck(:id, :name).to_h

    render json: { info: @task_info, collection: @collection, workspaces: @workspaces }
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
