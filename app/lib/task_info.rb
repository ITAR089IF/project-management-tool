class TaskInfo
  def initialize(user, id = nil)
    @user = user
    workspaces = @user.available_workspaces
    if id == nil
      @collection = workspaces
    else
      @collection = workspaces.find(id).projects
    end
  end

  def report
    task_info = []
    @collection.each do |item|
      incomplete = item.tasks.assigned_to(@user).incomplete
      due_soon = incomplete.due_soon.count
      outdated = incomplete.outdated.count
      incomplete = incomplete.count
      task_info.push({name: item.name, uncompleted: incomplete, 'due soon' => due_soon, outdated: outdated})
    end
    task_info
  end
end
