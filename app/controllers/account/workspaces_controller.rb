class Account::WorkspacesController < Account::AccountController
  def show
    @workspace = resource
    @members = @workspace.all_members.order_desc
  end

  def prepare_pdf
    @workspace = resource
    @members = @workspace.all_members.order_desc
    WorkspaceDetailsJob.perform_later(@workspace.id, current_user.id)
    render :show
  end

  def list
    @workspace = resource
  end

  def new
    @workspace = Workspace.new

    respond_to(:js)
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.save
    @workspaces = collection

    respond_to(:js)
  end

  def edit
    @workspace = resource

    respond_to(:js)
  end

  def update
    @workspace = resource
    @updated = @workspace.update(workspace_params)
    @workspaces = collection

    respond_to(:js)
  end

  def destroy
    @workspace = resource
    @workspace.destroy

    respond_to(:js)
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
