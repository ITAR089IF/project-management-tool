module Account::TasksHelper
  def task_style(section, duedate)
    classes = ''
    
    if section
      classes = 'title is-4 is-italic'
    elsif duedate
      classes = 'has-text-danger'
    else
      classes
    end
  end
end
