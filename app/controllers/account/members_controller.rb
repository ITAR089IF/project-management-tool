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
    MembersMailer.member_added(@shared_workspace.user, @workspace, current_user).deliver_later
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

    if !@invitation
      redirect_to root_path, notice: 'Sorry, could not identify following link'
      return
    end

    if @invitation.expired?
      redirect_to root_path, notice: 'Sorry, this link is no longer valid'
    else
      @workspace = @invitation.workspace
      @invitor = @invitation.invitor
      @token = @invitation.token
    end
  end

  def create_thought_link
    if @invitation = Invitation.find_by(workspace_id: params[:workspace_id], token: params[:token])
      @workspace = @invitation.workspace
      @shared_workspace = @workspace.shared_workspaces.build(user: current_user)
      if @shared_workspace.save
        redirect_to account_workspace_path(@workspace)
      end
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
