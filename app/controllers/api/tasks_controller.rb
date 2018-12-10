class Api::TasksController < Api::BaseController
  before_action :set_default_response_format

  def show
    @task = resource
  end

  def create
    @project = parent
    @task = @project.tasks.build(tasks_params)
    @task.creator = current_user
    if @task.save
      render :show, status: :created, location: api_project_task_url(@project, @task)
    else
      render json: { status: 'ERROR', errors: @task.errors}, status: 422
    end
  end

  def update
    @project = parent
    @task = resource

    if resource.update(tasks_params)
      render :show, status: :created, location: api_project_task_url(@project, @task)
    else
      render json: { status: 'ERROR', errors: @task.errors}, status: 422
    end
  end

  def destroy
    @project = parent
    @task = resource
    resource.destroy
    render json: { status: 'SUCCESS', message: 'Task deleted' }, status: :ok
  end

  private

  def set_default_response_format
    request.format = :json
  end

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
