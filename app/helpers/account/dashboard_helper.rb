module Account::DashboardHelper
  def available_workspaces
    current_user.available_workspaces
  end
end
