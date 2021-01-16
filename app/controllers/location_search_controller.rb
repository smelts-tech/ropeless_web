class LocationSearchController < ApplicationController
  def create
    redirect_to location_search_path(request.parameters)
  end

  def index
    meters = params[:radius].to_f * 1609.34 # meters per mile
    longitude, latitude = params[:longitude].presence, params[:latitude].presence
    @devices = if longitude && latitude
      Device.unique.where("ST_DWithin(geom, ST_MakePoint(#{params[:longitude]},#{params[:latitude]})::geography, #{meters})")
    else
      Device.none
    end
    @unique_devices = []
    # Yes, this will be ALL unique devices.  For now.
    Device.unique.each do |device|
      @unique_devices << {lat: device.geom.latitude,
                          lng: device.geom.longitude,
                          modem_id: device.modem_id,
                          device_event_time: device.dt,
                          event_type: device.event_type,
                          depth: device.depth,
                          altitude: device.altitude
      }
    end
  end
end
