class Device < ApplicationRecord
  before_save :set_geom
  belongs_to :fisher

  def latitude=(lat)
    @latitude = lat
  end

  def longitude=(long)
    @longitude = long
  end

  def set_geom
    if @longitude.present? && @latitude.present?
      results = ActiveRecord::Base.connection.execute("select ST_SetSRID(ST_MakePoint(#{@longitude}, #{@latitude}), 4326) as geom;")

      if results.present?
        self.geom = results.first['geom']
      end
    end
  end
end
