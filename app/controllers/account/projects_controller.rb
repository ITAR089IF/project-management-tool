class Account::ProjectsController < Account::AccountController
  before_action :set_workspace
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.order_desc(@workspace)
  end

  def show
    @tasks = @project.tasks.order(row_order: :asc)
  end

  def new
    @project = @workspace.projects.new
  end

  def create
    @project = @workspace.projects.new(project_params)

    if @project.save
      redirect_to account_workspace_projects_path(@workspace)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to account_workspace_projects_path(@workspace)
    else
      render :edit
    end
  end

  def destroy
    @project.delete
    redirect_to account_workspace_projects_path(@workspace)
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:workspace_id])
  end

  def set_project
    @project = @workspace.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
