class DashboardController < ApplicationController
  def index
    @fishers = Fisher.includes(:devices).all
    @devices = Device.includes(:fisher).all
  end
end
