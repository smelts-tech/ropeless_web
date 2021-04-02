class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user_admin?
    current_user && current_user.class.name == "User"
  end
  helper_method :current_user_admin?

  def current_user_fisher?
    current_user && current_user.class.name == "Fisher"
  end
  helper_method :current_user_fisher?
end
