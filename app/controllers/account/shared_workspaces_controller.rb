class Account::SharedWorkspacesController < Account::AccountController
  def new
    @workspace = resource
    @shared_workspace = @workspace.shared_workspaces.build

    respond_to :js
  end

  def create
    @workspace = resource
    @invitation = @workspace.shared_workspaces.build(shared_workspace_params)
    @invitation.save

    respond_to :js
  end

  def destroy
    @workspace = resource
    @invitation = @workspace.shared_workspaces.find(params[:id])
    @user = @invitation.user
    @invitation.destroy
    if @user == current_user
      redirect_to account_workspaces_path, notice: 'You have removed yourself from workspace!'
    else
      respond_to :js
    end
  end

  private

  def collection
    current_user.available_workspaces
  end

  def resource
    collection.find(params[:workspace_id])
  end

  def shared_workspace_params
    params.require(:shared_workspace).permit(:user_id).merge!(workspace_id: params[:workspace_id])
  end
end
