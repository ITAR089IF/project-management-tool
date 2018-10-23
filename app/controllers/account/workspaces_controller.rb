class Account::WorkspacesController < Account::AccountController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  def index
    @workspaces = current_user.workspaces.order(created_at: :desc)
  end

  def show
  end

  def new
    @workspace = current_user.workspaces.new
  end

  def create
    @workspace = current_user.workspaces.new(workspace_params)

    if @workspace.save
      redirect_to account_workspaces_path, notice: 'Workspace was created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workspace.update_attributes(workspace_params)
      redirect_to account_workspace_path(@workspace), notice: 'Workspace was updated!'
    else
      render :edit
    end
  end

  def destroy
    @workspace.delete
    redirect_to account_workspaces_path
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name)
  end
end
