class Admin::AdminController < ApplicationController
  impersonates :user

  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @workspaces = user.workspaces
  end

  def edit
    @user = user
  end

  def update
    @user = user

    if @user.update(users_params)
      redirect_to admin_admin_index_path
    else
      render :edit
    end
  end

  def destroy
    @user = user
    @user.destroy

    redirect_to admin_admin_index_path
  end

  private

  def require_admin!
    redirect_to root_path unless true_user.admin?
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :role, :department, :about, :avatar, :job_role)
  end

  def user
    User.find_by(id: params[:id])
  end



end
