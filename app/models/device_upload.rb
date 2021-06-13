class DeviceUpload < ApplicationRecord
  has_one_attached :uploaded_file

  belongs_to :fisher, inverse_of: :device_uploads

  class DeviceUpload::InvalidDocument < StandardError; end

  def data=(value)
    @data = value
    uploaded_file.attach(
      io: StringIO.new(value),
      filename: 'raw_data.xml',
      content_type: 'text/xml'
    )
  end

  def process!
    begin
    doc = Nokogiri::XML(uploaded_file.download)
    rescue Nokogiri::XML::SyntaxError => e
      raise InvalidDocument
    end

    validateFile(doc)

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

    device = fisher.devices.new
    device.dt = dt
    device.modem_id = modem_id
    device.event_type = event_type
    device.latitude = lat
    device.longitude = long
    device.altitude = altitude
    device.depth = depth
    device.md5_hash = md5.hexdigest
    begin
      device.save!
    rescue ActiveRecord::RecordNotUnique => e
      puts 'Eating PG::UniqueViolation error.  MD5 of this record exists.'
    rescue StandardError => e
      # stop processing of this file
      raise e
    end
  end

  def validateFile(doc)
    # must have at least one item
    raise InvalidDocument.new "Missing FishingData/item records" if doc.xpath('//FishingData//item').length == 0
  end
end
