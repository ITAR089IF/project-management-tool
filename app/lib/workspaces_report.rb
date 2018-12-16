class WorkspacesReport
  def initialize(user)
    @user = user
  end

  def report
    @user.available_workspaces.pluck(:id, :name).to_h
  end
end
