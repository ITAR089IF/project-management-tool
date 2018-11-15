class Account::MembersController < Account::AccountController
  def new
    @workspace = resource
    @shared_workspase = @workspace.shared_workspaces.build

    respond_to :js
  end

  def create
    @workspace = resource
    @shared_workspace = @workspace.shared_workspaces.build(user_id: member_params[:user_id])
    @shared_workspace.save

    respond_to :js
  end

  def destroy
    @workspace = resource
    @shared_workspace = @workspace.shared_workspaces.find_by(user_id: params[:id])
    @user = @shared_workspace.user
    @shared_workspace.destroy
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

  def member_params
    params.require(:shared_workspace).permit(:user_id).merge!(workspace_id: params[:id])
  end
end
