class Account::ProfilesController < ApplicationController
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

  def delete_avatar
    @user = current_user
    @avatar = ActiveStorage::Attachment.find(current_user.avatar.id)
    @avatar.purge_later

    respond_to :js
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :role, :department, :about, :avatar, :job_role)
  end
end
