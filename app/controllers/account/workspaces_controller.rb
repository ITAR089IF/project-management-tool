class Account::WorkspacesController < Account::AccountController
  def index
    @workspaces = collection.order_desc
    @workspace = Workspace.new
  end

  def show
    @workspace = resource
    @members = @workspace.all_members.order_desc
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspaces = collection.order_desc
    @workspace = Workspace.new(workspace_params)
    @workspace.save
    respond_to(:js)
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
