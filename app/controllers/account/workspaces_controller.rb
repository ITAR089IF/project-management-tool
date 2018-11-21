class Account::WorkspacesController < Account::AccountController
  def index
    @workspaces = collection.order_desc
  end

  def show
    @workspace = resource
    @members = @workspace.all_members.order_desc
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Workspace.new(workspace_params)
    if @workspace.save
      redirect_to account_workspaces_path, notice: 'Workspace was created!'
    else
      render :new
    end
  end

  def edit
    @workspace = resource
  end

  def update
    @workspace = resource
    if @workspace.update(workspace_params)
      redirect_to account_workspace_path(@workspace), notice: 'Workspace was updated!'
    else
      render :edit
    end
  end

  def destroy
    resource.destroy
    redirect_to account_workspaces_path
  end

  def create_invitation_link
    workspace = collection.find(params[:workspace_id])
    token = Devise.friendly_token
    @invitation = Invitation.new(invitor: current_user, workspace: workspace, token: token)

    if @invitation.save
      @short_link = Bitly.client.shorten("http://www.#{request.host}/account/workspaces/#{workspace.id}/members/greeting_new_member?token=#{token}").short_url

      respond_to :js
    end
  end

  private
  def collection
    current_user.available_workspaces
  end

  def resource
    collection.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name).merge(user_id: current_user.id)
  end
end
