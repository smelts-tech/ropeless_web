class DevicesController < ApplicationController
  def show
    @device = Device.find(params[:id])
    @fisher = Fisher.find(@device.fisher_id)
  end
end
