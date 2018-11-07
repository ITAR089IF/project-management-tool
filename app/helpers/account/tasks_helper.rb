module Account::TasksHelper
  def task_style(task)
    if task.section?
      'title is-4 is-italic'
    elsif task.expired?
      'has-text-danger'
    else
      ""
    end
  end
end
