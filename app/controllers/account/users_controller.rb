class Account::UsersController < ApplicationController
  def edit
  @user = current_user
end

def update
  @user = current_user

  if @user.update(users_params)
    redirect_to account_dashboard_path, notice: "Profile successfully updated!"
  else
    render :edit
  end
end

def users_params
  params.require(:user).permit(:first_name, :last_name, :role, :department, :about_me)
end
end
