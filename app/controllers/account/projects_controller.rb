class Account::ProjectsController < Account::AccountController
  def show
    @workspace = parent
    @project = @workspace.projects.find(params[:id])
    @tasks = @project.tasks.row_order_asc
  end

  def new
    @workspace = parent
    @project = current_user.projects.build
  end

  def create
    if current_user.projects.create(project_params)
      redirect_to account_workspace_path(parent)
    else
      render :new
    end
  end

  def edit
    @workspace = parent
    @project = @workspace.projects.find(params[:id])
  end

  def update
    @project = resource

    if @project.update(project_params)
      redirect_to account_workspace_path(parent)
    else
      render :edit
    end
  end

  def destroy
    resource.destroy
    redirect_to account_workspace_path(parent)
  end

  private

  def parent
    current_user.workspaces.find(params[:workspace_id])
  end

  def resource
    parent.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name).merge(workspace_id: params[:workspace_id])
  end
end
