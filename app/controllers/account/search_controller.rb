class Account::SearchController < Account::AccountController
  def index
    render json: {
      workspaces: current_user.workspaces.search_workspaces(params[:search]),
      projects: current_user.projects.search_projects(params[:search]),
      tasks: current_user.search_tasks(params[:search])
    }
  end
end
