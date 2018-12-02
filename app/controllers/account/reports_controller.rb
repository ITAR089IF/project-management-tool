class Account::ReportsController < Account::AccountController
  def workspace
    @workspace = parent
  end

  def project
    @workspace = parent
    @project = @workspace.projects.find(params[:id])

    respond_to :js
  end

  private

  def parent
    current_user.available_workspaces.find(params[:workspace_id])
  end
end
