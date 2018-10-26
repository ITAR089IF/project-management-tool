class Account::TasksController < Account::AccountController
  def show
    @comments = resource.comments.order(created_at: :desc).page(params[:page]).per(5)
    @project = parent
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
  end

  def new
    @project = parent
    @task = @project.tasks.build
  end

  def create
    @task = collection.build(tasks_params)
    if @task.save
      redirect_to account_workspace_project_path(parent.workspace_id, parent)
    else
      render :new
    end
  end

  def edit
    @project = parent
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = resource

    if @task.update(tasks_params)
      redirect_to account_project_task_path(parent.id, @task)
    else
      render "edit"
    end
  end

  def destroy
    resource.destroy
    redirect_to account_workspace_project_path(parent.workspace_id, parent.id)
  end

  def move
    resource.update_attributes(task_movement_params)
    redirect_to account_workspace_project_path(parent.workspace_id, parent.id)
  end

  private

  def parent
    current_user.projects.find(params[:project_id])
  end

  def collection
    parent.tasks
  end

  def resource
    parent.tasks.find(params[:id])
  end

  def tasks_params
    params.require(:task).permit(:title, :description)
  end

  def task_movement_params
    params.require(:task).permit(:row_order_position)
  end
end
