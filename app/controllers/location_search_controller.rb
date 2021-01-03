class LocationSearchController < ApplicationController
  def create
    redirect_to location_search_path(request.parameters)
  end

  def index
    meters = params[:radius].to_f * 1609.34 # meters per mile
    @devices = Device.unique.where("ST_DWithin(geom, ST_MakePoint(#{params[:longitude]},#{params[:latitude]})::geography, #{meters})")
    @unique_devices = Device.unique.collect do |device|
        [ device.geom.latitude, device.geom.longitude, device.modem_id ]
    end
  end
end
