require 'aws-sdk-s3' #if ENV['RACK_ENV'] == 'test'
require 'digest'
require 'pg'
require 'rgeo/geo_json'

class FileProcessor
  def initialize(tmp_file)
    @tmp_file = tmp_file
  end

  def process
    # process xml from @tmp_file
    doc = Nokogiri::XML(File.open(@tmp_file))
    doc.elements.each('FishingData/item') do |e|
      modem_id = e.elements().to_a('Name').first.text
      event_type = e.elements().to_a('Type').first.text
      lat = e.elements().to_a('Latitude').first&.text
      long = e.elements().to_a('Longitude').first&.text
      altitude = e.elements().to_a('Altitude').first&.text
      depth = e.elements().to_a('Depth').first&.text
      dt = e.elements().to_a('CreationDateAndTime').first.text
      fisher_name = e.elements().to_a('FisherName').first.text
      fisher_permit_number = e.elements().to_a('FisherPermitNumber').first.text
      user_id = save_user(fisher_name, fisher_permit_number)
      save_record(user_id, modem_id, event_type, lat, long, altitude, depth, dt)
    end
  end

  def save_user(fisher_name, fisher_permit_number)

    return 0
  end

  def save_record(user_id, modem_id, event_type, lat, long, altitude, depth, dt)
    md5 = Digest::MD5.new
    md5 << modem_id
    md5 << event_type
    md5 << dt

    geo_set = lat.nil? ? 'null' : "ST_SetSRID(ST_MakePoint(#{long}, #{lat}), 4326)"
    altitude_set = altitude.nil? ? 'null' : altitude
    depth_set = depth.nil? ? 'null' : depth

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
  end

end