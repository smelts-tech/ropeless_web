class DevicesController < ApplicationController
  def show
    @device = Device.find(params[:id])
    @fisher = Fisher.find(@device.fisher_id)
    @ordered_event_list = Device.where(:modem_id => @device.modem_id).order(dt: :desc)
  end
end
