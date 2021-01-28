class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def current_user_admin?
    current_user && current_user.class.name == "User"
  end
  helper_method :current_user_admin?
end
