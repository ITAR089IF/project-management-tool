class Account::ProjectsController < Account::AccountController
  def show
    @workspace = parent
    @project = resource
    @comments = @project.comments.order_desc.page(params[:page]).per(5)
    @comment = @project.comments.build
    @tasks = @project.tasks.row_order_asc
  end

  def new
    @workspace = parent
    @project = collection.build

    respond_to :js
  end

  def create
    @workspace = parent
    @project = @workspace.projects.build(project_params)
    @project.save

    respond_to :js
  end

  def edit
    @workspace = parent
    @project = resource

    respond_to :js
  end

  def update
    @workspace = parent
    @project = resource
    @result = @project.update(project_params)

    respond_to :js
  end

  def destroy
    @workspace = parent
    @project = resource
    @project.destroy

    respond_to :js
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
    params.require(:project).permit(:name).merge(users: [current_user])
  end
end
