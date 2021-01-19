module ApplicationHelper
  def current_user_admin?
    current_user.is_a?(User)
  end
end
