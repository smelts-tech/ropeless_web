class Device < ApplicationRecord
  before_save :set_geom
  belongs_to :fisher

  scope :unique, -> { where('id in (SELECT T1.id
           FROM devices as T1
           WHERE NOT EXISTS(
                    SELECT *
                    FROM devices AS T2
                    WHERE T2.modem_id = T1.modem_id AND T2.dt > T1.dt
           ))') }

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
