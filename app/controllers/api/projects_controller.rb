class Api::ProjectsController < ActionController::API

  def show
    @project = resource
  end

  def create
    @workspace = parent
    @project = @workspace.projects.build(project_params)
    if  @project.save
      render json: { status: 'SUCCESS', message: 'Project saved' }, status: :ok
    else
      render json: { status: 'ERROR', errors: @project.errors}, status: 422
    end
  end

  def update
    @workspace = parent
    @project = resource
    if @project.update(project_params)
      render json: { status: 'SUCCESS', message: 'Project updated' }, status: :ok
    else
      render json: { status: 'ERROR', errors: @project.errors}, status: 422
    end
  end

  def destroy
    @workspace = parent
    @project = resource
    @project.destroy

    render json: { status: 'SUCCESS', message: 'Project deleted' }, status: :ok
  end

  private

  def parent
    current_user.available_workspaces.find(params[:workspace_id])
  end

  def collection
    parent.projects
  end

  def resource
    collection.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description).merge(users: [current_user])
  end
end
