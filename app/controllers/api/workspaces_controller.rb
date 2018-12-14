class Api::WorkspacesController < ActionController::API

  def index
    @workspaces = collection
  end

  def show
    @workspace = resource
    @members = @workspace.all_members
  end

  def create
    @workspace = Workspace.new(workspace_params)

    if @workspace.save
      render :show,  status: :created, location: api_workspace_url(@workspace)
    else
      render json: { status: 'ERROR', errors: @workspace.errors}, status: 422
    end
  end

  def update
    @workspace = resource
    if @workspace.update(workspace_params)
      render :show,  status: :created, location: api_workspace_url(@workspace)
    else
      render json: { status: 'ERROR', errors: @workspace.errors}, status: 422
    end
  end

  def destroy
    resource.destroy
    render json: { status: 'SUCCESS', message: 'Workspace deleted' }, status: :ok
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
