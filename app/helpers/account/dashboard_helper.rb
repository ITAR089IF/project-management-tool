module Account::DashboardHelper
  def is_ahead?(date)
    date >= Date.today
  end

  def workspaces_wiht_pojects
    current_user.available_workspaces
  end
end
