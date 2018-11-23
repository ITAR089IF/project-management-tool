class Account::ProjectsController < Account::AccountController
  def show
    @workspace = parent
    @project = resource
    @comments = @project.comments.order_desc.page(params[:page]).per(5)
    @comment = @project.comments.build
    @all_tasks = @project.tasks.row_order_asc
  end

  def new
    @workspace = parent
    @project = collection.build
  end

  def create
    @workspace = parent
    @project = @workspace.projects.build(project_params)

    if  @project.save
      redirect_to account_workspace_path(@workspace), notice: "Project was successfully created!"
    else
      render :new
    end
  end

  def edit
    @workspace = parent
    @project = resource
  end

  def update
    @workspace = parent
    @project = resource

    if @project.update(project_params)
      redirect_to account_workspace_path(@workspace), notice: "Project was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    resource.destroy
    redirect_to account_workspace_path(parent), alert: "Project was successfully deleted!"
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all(row_order: index + 1)
    end
    head :ok
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
