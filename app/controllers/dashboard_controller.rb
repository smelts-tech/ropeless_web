class DashboardController < ApplicationController
  def show
    @fishers = Fisher.includes(:devices).all
    @devices = Device.includes(:fisher).all
  end
end
