class Account::WorkspacesController < Account::AccountController
  def index
    @workspaces = collection.order_desc
  end

  def show
    @workspace = resource
    @users = User.for(@workspace).order_desc
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

  def new_member
    @workspace = resource

    respond_to :js
  end

  def create_member
    @workspace = resource
    @invitation = @workspace.shared_workspaces.build(user_id: member_params[:user_id])
    @invitation.save

    respond_to :js
  end

  def delete_member
    @workspace = resource
    @member_id = resource.members.find(params[:user]).id
    resource.members.destroy(params[:user])
    if @member_id == current_user.id
      redirect_to account_workspaces_path, notice: 'You have removed yourself from workspace!'
    else
      respond_to :js
    end
  end

  private
  def collection
    current_user.workspaces.union(current_user.invited_workspaces)
  end

  def resource
    collection.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name).merge(user_id: current_user.id)
  end

  def member_params
    params.require(:workspace).permit(:user_id)
  end
end
