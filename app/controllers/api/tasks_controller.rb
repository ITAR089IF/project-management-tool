class Api::TasksController < ActionController::API

  def show
    @project = parent
    @task = resource
    @comments = @task.comments
  end

  def create
    @project = parent
    @task = @project.tasks.build(tasks_params)

    if @task.save
      render json: { status: 'SUCCESS', message: 'Task saved' }, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = parent
    @task = resource

    if resource.update(tasks_params)
      render json: { status: 'SUCCESS', message: 'Task updated' }, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = parent
    @task = resource
    resource.destroy
    render json: { status: 'SUCCESS', message: 'Task deleted' }, status: :ok
  end

  private

  def parent
    current_user.available_projects.find(params[:project_id])
  end

  def collection
    parent.tasks
  end

  def resource
    parent.tasks.find(params[:id])
  end

  def tasks_params
    params.require(:task).permit(:title, :description, :section, :due_date, :completed_at, files: [])
  end
end