class Account::MembersController < Account::AccountController
  def new
    @workspace = resource
    @shared_workspaсe = @workspace.shared_workspaces.build

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

  def greeting_new_member
    @invitation = Invitation.find_by(token: params[:token], workspace_id: params[:workspace_id])

    if @invitation.present? && @invitation&.created_at >= 14.days.ago
      @workspace = Workspace.find(params[:workspace_id])
      @invitor = User.find(@invitation.invitor_id)
    elsif @invitation.present? && @invitation&.created_at < 14.days.ago

      redirect_to root_path, notice: 'Sorry, this link is no longer valid'
    else

      redirect_to root_path, notice: 'Sorry, could not identify following link'
    end
  end

  def create_thought_link
    @workspace = Workspace.find(params[:workspace_id])
    @shared_workspace = @workspace.shared_workspaces.build(user_id: params[:user_id])
    if @shared_workspace.save
      redirect_to account_workspace_path(@workspace)
    else
      redirect_to root_path, notice: 'Something went wrong! Please, try again later.'
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
