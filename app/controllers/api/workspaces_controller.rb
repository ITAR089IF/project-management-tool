class Api::WorkspacesController < ApplicationController
  def index
    @workspaces = collection
    render json: @workspaces
  end

  def create
    @workspace = Workspace.new(workspace_params)
    if @workspace.save
      render json: @workspace
    else
      invalid_resource!(@workspace)
    end
  end

  def show
    @workspace = resource
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
