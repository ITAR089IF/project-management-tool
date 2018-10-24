class Account::ProjectsController < Account::AccountController
  def index
    @workspace = parent
    @projects = collection.order_desc
  end

  def show
    @workspace = parent
    @project = resource
    @tasks = @project.tasks.row_order_asc
  end

  def new
    @workspace = parent
    @project = collection.build
  end

  def create
    @project = collection.build(project_params)

    if @project.save
      redirect_to account_workspace_projects_path(@workspace)
    else
      render :new
    end
  end

  def edit
    @workspace = parent
    @project = resource
  end

  def update
    @project = resource

    if @project.update(project_params)
      redirect_to account_workspace_projects_path(@workspace)
    else
      render :edit
    end
  end

  def destroy
    resource.destroy
    redirect_to account_workspace_projects_path(@workspace)
  end

  private

  def parent
    current_user.workspaces.find(params[:workspace_id])
  end

  def collection
    parent.projects
  end

  def resource
    parent.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
