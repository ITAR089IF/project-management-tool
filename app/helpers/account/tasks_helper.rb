module Account::TasksHelper
  def task_link_class(task)
    if task.section?
      'title is-4 is-italic'
    elsif task.expired?
      'has-text-danger'
    else
      'has-text-link'
    end
  end

  def section_or_task
    params[:section].nil? ? 'Task' : 'Section'
  end
end
