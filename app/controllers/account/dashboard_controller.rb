class Account::DashboardController < Account::AccountController
  def index
  end

  def calendar
    @user_tasks = current_user.tasks
  end
end
