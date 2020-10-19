class DeviceUpload < ApplicationRecord
  has_one_attached :uploaded_file

  belongs_to :fisher, inverse_of: :device_uploads

  class DeviceUpload::InvalidDocument < StandardError; end

  def process!
    # Albertgrimley's processing should go here and should raise `DeviceUpload::InvalidDocument` if something's wrong
  end
end
