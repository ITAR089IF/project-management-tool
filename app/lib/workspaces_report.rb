class WorkspacesReport
  def initialize(user)
    @user = user
  end

  def report
    @user.available_workspaces.to_json(:only => [ :id, :name])
  end
end
