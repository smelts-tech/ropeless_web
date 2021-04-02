class LandingController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :redirect_if_user_signed_in

  def show
  end

  private

  def redirect_if_user_signed_in
    redirect_to dashboard_url if user_signed_in?
  end
end
