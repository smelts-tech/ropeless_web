class DeviceUpload < ApplicationRecord
  has_one_attached :uploaded_file

  belongs_to :fisher, inverse_of: :device_uploads

  class DeviceUpload::InvalidDocument < StandardError; end

  def process!
    begin
    doc = Nokogiri::XML(uploaded_file.download)
    raise InvalidDocument unless fileValid?(doc)
    rescue Nokogiri::XML::SyntaxError => e
      raise InvalidDocument
    end
    doc.xpath('//FishingData//item').each do |e|
      modem_id = e.xpath('Name').inner_text
      event_type = e.xpath('Type').inner_text
      lat = e.xpath('Latitude').inner_text
      long = e.xpath('Longitude').inner_text
      altitude = e.xpath('Altitude').inner_text
      depth = e.xpath('Depth').inner_text
      dt = e.xpath('CreationDateAndTime').inner_text
      fisher_name = e.xpath('FisherName').inner_text
      fisher_permit_number = e.xpath('FisherPermitNumber').inner_text
      user_id = save_user(fisher_name, fisher_permit_number)
      save_record(user_id, modem_id, event_type, lat, long, altitude, depth, dt)
    end
  end

  def save_user(fisher_name, fisher_permit_number)
    # TODO - do we still need to do this?

    return 0
  end

  def save_record(user_id, modem_id, event_type, lat, long, altitude, depth, dt)
    md5 = Digest::MD5.new
    md5 << modem_id
    md5 << event_type
    md5 << dt

    geo_set = lat.blank? ? 'null' : "ST_SetSRID(ST_MakePoint(#{long}, #{lat}), 4326)"
    altitude_set = altitude.blank? ? 'null' : altitude
    depth_set = depth.blank? ? 'null' : depth

    device = fisher.devices.new
    device.dt = dt
    device.modem_id = modem_id
    device.event_type = event_type
    device.md5_hash = md5.hexdigest
    device.save!

    # TODO - make sure the unique constraint is in place and working


=begin
    begin
      @db_conn.exec("insert into devices (fisher_id, dt, modem_id, event_type, geom, altitude, depth, created_at, updated_at, md5_hash)
                          values (#{user_id},
                                  '#{dt}',
                                  '#{modem_id}',
                                  '#{event_type}',
                                  #{geo_set},
                                  #{altitude_set},
                                  #{depth_set},
                                  '#{Time.now.utc}',
                                  '#{Time.now.utc}',
                                  '#{md5.hexdigest}')")
    rescue PG::UniqueViolation => e
      puts 'Eating PG::UniqueViolation error.  MD5 of this record exists.'
    rescue StandardError => e
      # stop processing of this file
      raise e
    end
=end
  end

  def fileValid?(doc)
    # xslt validation here
    return true
  end
end
