class Location
  include ActiveModel::Validations

  attr_accessor :latitude, :longitude, :radius

  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :radius, presence: true, numericality: true

  def initialize(params={})
    @latitude  = params[:latitude]
    @longitude = params[:longitude]
    @radius = params[:radius]
    ActionController::Parameters.new(params).permit(:latitude,:longitude,:radius)
  end
end