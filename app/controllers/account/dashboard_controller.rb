class Account::DashboardController < Account::AccountController
  def index
  end

  def calendar
    @user_tasks = current_user.followed_tasks
  end

  def inbox
    @user_completed_tasks = current_user.followed_tasks.complete
  end
end
