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
      if @task.section?
        redirect_to account_workspace_project_path(@project.workspace_id, @project)
      else
        @task.add_watcher(current_user)
        redirect_to account_project_task_path(@project, @task)
      end
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
      redirect_to @task.section? ? account_workspace_project_path(@project.workspace_id, @project) : account_project_task_path(@project, @task)
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
    @project = parent
    @task = resource
    @tasks = @project.tasks.row_order_asc
    params[:move][:move_positions].to_i.times do
      @task.update(row_order_position: params[:move][:move_option].to_sym)
    end
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
    @result = @task.assign!(assignee_params[:assignee], current_user)
    unless @task.assignee.watching?(@task)
      @task.add_watcher(@task.assignee)
    end

    TasksMailer.task_assign_to_user_email(@task).deliver_later if @task.saved_change_to_assignee_id?
    respond_to :js
  end

  def unassign
    @project = parent
    @task = resource
    @result = @task.update(assignee_id: nil, assigned_by_id: nil)

    respond_to :js
  end

  def remove_attachment
    @project = parent
    @task = resource
    @task.files.find(params[:attachment_id]).purge
    redirect_to account_project_task_path(@project, @task)
  end

  def toggle_complete
    @project = parent
    @task = resource
    if @task.pending?
      @task.complete!(current_user)
    else
      @task.update(completed_at: nil)
    end
    ActionCable.server.broadcast "project_#{@project.id}", { id: @project.id,
                                                            task_id: @task.id,
                                                            task: render_task(@project, @task) }
  end

  def report
    pdf = ProjectTasksPdfReport.new(parent.name, collection.this_week)

    send_data pdf.render,
      filename: "weekly_report_for_#{parent.name}.pdf",
      type: 'application/pdf',
      disposition: 'attachment'
  end

  def new_task_from_calendar
    @task = Task.new
    @task.due_date = params[:due_date]

    respond_to :js
  end

  def create_task_from_calendar
    @project = current_user.available_projects.where(id: calendar_task_params[:project_id])[0]
    if @project.present?
      @task = @project.tasks.build(calendar_task_params)
      if @task.save
        @task.watchers << current_user
      end
    else
      @task = Task.create(calendar_task_params)
    end

    respond_to :js
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

  def calendar_task_params
    params.require(:task).permit(:project_id, :title, :description, :due_date, files: [])
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

  def valid_date?(date)
    date >= Date.today
  end
  
  def render_task(project, task)
    render(partial: 'account/projects/show_task', locals: { project: project, task: task })
  end
end
