class DashboardController < ApplicationController
  def show
    @fishers = Fisher.includes(:devices).all
    @devices = Device.includes(:fisher)

    if current_user_fisher?
      @devices = @devices.where(fisher: current_user)
    end

    @devices = @devices.all
  end
end
