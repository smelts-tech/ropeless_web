class LocationSearchController < ApplicationController
  def create
    redirect_to location_search_path(request.parameters)
  end

  def index
    meters = params[:radius].to_f * 1609.34 # meters per mile
    @devices = Device.unique.where("ST_DWithin(geom, ST_MakePoint(#{params[:longitude]},#{params[:latitude]})::geography, #{meters})")
  end
end
