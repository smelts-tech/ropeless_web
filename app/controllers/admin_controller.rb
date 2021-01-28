class AdminController < ApplicationController
  before_action :require_admin_user

  private

  def require_admin_user
    redirect_to root_url and return unless current_user_admin?
  end
end
