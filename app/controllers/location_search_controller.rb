class LocationSearchController < ApplicationController
  before_action :validate_params, only: [:create, :index]

  def create
    redirect_to location_search_path(request.parameters)
  end

  def index
    meters = params[:radius].to_f * 1609.34 # meters per mile
    @devices = Device.unique.where("ST_DWithin(geom, ST_MakePoint(#{params[:longitude]},#{params[:latitude]})::geography, #{meters})")
  end

  private

  def validate_params
    #@location = Location.new(params)
    #if !@location.valid?
    #  render json: { error: @location.errors } and return
    #end
  end

end
