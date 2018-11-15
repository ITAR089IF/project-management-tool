class Admin::AdminController < ApplicationController
  impersonates :user

  before_action :authenticate_user!

  private

  def require_admin!
    redirect_to root_path unless true_user.admin?
  end
end
