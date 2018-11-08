class Account::WorkspacesController < Account::AccountController
  def index
    @workspaces = collection

    respond_to do |format|
      format.html { @workspaces.order_desc }
      format.json { render json: { workspaces: @workspaces.search_by_name(params[:search]) }}
    end
  end

  def show
    @workspace = resource
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

  private

  def collection
    current_user.workspaces
  end

  def resource
    collection.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name).merge(user_id: current_user.id)
  end
end
