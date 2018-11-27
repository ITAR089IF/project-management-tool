class Admin::UsersController < Admin::AdminController
  before_action :require_admin!

  def impersonate
    user = resource
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  def index
    @users = User.all
  end

  def show
    @user = resource
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    if @user.update(users_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to  admin_users_path
  end

 private

 def users_params
   params.require(:user).permit(:first_name, :last_name, :role, :department, :about, :avatar, :job_role)
 end

 def resource
   User.find_by(id: params[:id])
 end

end
