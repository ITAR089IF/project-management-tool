class Admin::UsersController < Admin::AdminController
  before_action :require_admin!

  def impersonate
    user = parent
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
    @user = parent
  end

  def edit
    @user = parent
  end

  def update
    @user = parent
    if @user.update(users_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = parent
    @user.destroy
    redirect_to  admin_users_path
  end

 private

 def users_params
   params.require(:user).permit(:first_name, :last_name, :role, :department, :about, :avatar, :job_role)
 end

 def parent
   User.find_by(id: params[:id])
 end

end
