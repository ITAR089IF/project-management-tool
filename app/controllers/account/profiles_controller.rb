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
    @avatar = ActiveStorage::Attachment.find_by(params[:id])
    @avatar.purge_later
    redirect_back(fallback_location: account_profile_path)
  end

  def users_params
    params.require(:user).permit(:first_name, :last_name, :role, :department, :about, :avatar, :job_role)
  end
end
