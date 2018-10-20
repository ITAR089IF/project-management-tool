class Account::TasksController < Account::AccountController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(tasks_params)

    if @task.save
      redirect_to account_project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(tasks_params)
      redirect_to account_project_task_path(@project, @task)
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to account_project_path(@project)
  end

  def move
    Task.find(params[:task_id]).update_attribute(:row_order_position, params[:move])
    redirect_to account_project_path(@project)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def tasks_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
