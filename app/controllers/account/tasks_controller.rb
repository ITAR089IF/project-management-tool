class Account::TasksController < Account::AccountController

  def show
    @project = parent
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.order_desc.page(params[:page]).per(5)
    @comment = @task.comments.build
  end

  def new
    @project = parent
    @task = @project.tasks.build(section_params)
  end

  def create
    @project = parent
    @task = @project.tasks.build(tasks_params)

    if @task.save
      redirect_to account_project_task_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @project = parent
    @task = @project.tasks.find(params[:id])
  end

  def update
    @project = parent
    @task = resource

    if resource.update(tasks_params)
      redirect_to account_project_task_path(@project, @task)
    else
      render "edit"
    end
  end

  def destroy
    @project = parent
    @task = resource
    resource.destroy
    respond_to do |f|
      f.js
      f.html { redirect_to account_workspace_project_path(parent.workspace_id, parent) }
    end
  end

  def move
    resource.update(task_movement_params)
    redirect_to account_workspace_project_path(parent.workspace_id, parent)
  end

  def watch
    @project = parent
    @task = @project.tasks.find(params[:id])

    if current_user.watching?(@task)
      @task.remove_watcher(current_user)
    else
      @task.add_watcher(current_user)
    end

    respond_to(:js)
  end

  def choose_assignee
    @project = parent
    @task = @project.tasks.find(params[:id])

    respond_to :js
  end

  def assign
    @project = parent
    @task = @project.tasks.find(params[:id])
    TasksMailer.task_assign_to_user_email(@task).deliver if  @task.update(assignee_id: assignee_params[:assignee])
    @result = @task
    respond_to :js
  end

  def unassign
    @project = parent
    @task = resource
    @result = @task.update(assignee_id: nil)
    respond_to :js
  end

  def remove_attachment
    @project = parent
    @task = resource
    @task.files.find(params[:attachment_id]).purge

    redirect_to account_project_task_path(@project, @task)
  end

  def complete
    @project = parent
    @task = resource
    @task.update(complete: true)
    respond_to :js
    TasksMailer.task_completed(@task, current_user).deliver_later
  end


  def uncomplete
    @project = parent
    @task = resource
    @task.update(complete: false)
    respond_to :js
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
    params.require(:task).permit(:title, :description, :section, :due_date, files: [])
  end

  def task_movement_params
    params.require(:task).permit(:row_order_position)
  end

  def section_params
    params.permit(:section)
  end

  def assignee_params
    params.require(:task).permit(:assignee)
  end
end
