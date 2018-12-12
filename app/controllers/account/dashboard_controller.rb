class Account::DashboardController < Account::AccountController
  after_action :change_messages_read, only: :inbox

  def index
  end

  def top_workspaces_card

  end
  
  def user_info_card

  end

  def user_info
    array_of_dates = (6.days.ago.to_date..Date.today).map{ |date| date }
    @user_info = []
    array_of_dates.each do |date|
      created_tasks = current_user.created_tasks.created_at_date(date).count
      assigned_tasks = current_user.assigned_tasks.assigned_at_date(date).count
      completed_tasks = current_user.completed_tasks.created_at_date(date).count
      @user_info.push(created: created_tasks, assigned: assigned_tasks, completed: completed_tasks, date: date.strftime("%d/%m/%y"))
    end
    render json: @user_info
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