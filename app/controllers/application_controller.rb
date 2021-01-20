class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user_admin?
    current_user && current_user.class.name == "User"
  end
  helper_method :current_user_admin?

  def require_admin_user
    redirect_to root_url and return unless current_user_admin?
  end
end
