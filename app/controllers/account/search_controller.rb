class Account::SearchController < Account::AccountController
  def index
    render json: {
      workspaces: current_user.workspaces.search_workspaces(params[:search]),
      projects: current_user.projects.search_projects(params[:search]),
      tasks: Task.search_tasks(current_user.id, params[:search])
    }
  end
end
