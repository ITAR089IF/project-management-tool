class TopWorkspaces
  def initialize(user)
    @user = user
    @workspaces = @user.available_workspaces
  end

  def report
    @top_workspaces = []
    @workspaces.each do |workspace|
      @incomplete = workspace.tasks.incomplete.count
      @complete = workspace.tasks.complete.count
      @top_workspaces.push({name: workspace.name, uncompleted: @incomplete, completed: @complete})
      @top_workspaces.sort_by! { |k| k[:completed] }.reverse!
    end

    @top_five_workspaces = @top_workspaces.first(5)
  end
end
