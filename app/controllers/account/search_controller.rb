class Account::SearchController < Account::AccountController
  def index
    render json: {
      workspaces: current_user.available_workspaces.search_workspaces(params[:search]),
      projects: current_user.available_projects.search_projects(params[:search]),
      tasks: current_user.available_tasks.search_tasks(params[:search])
    }
  end
end
