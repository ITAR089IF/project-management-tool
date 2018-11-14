class Admin::AdminController < ApplicationController
  impersonates :user

  before_action :authenticate_user!

  def require_admin!
    redirect_to root_path unless current_user.admin?
  end
end
