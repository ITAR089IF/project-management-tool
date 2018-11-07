module Account::TasksHelper
  def task_class(task)
    if task.section?
      'title is-4 is-italic'
    elsif task.expired?
      'has-text-danger'
    else
      'is-link'
    end
  end
end
