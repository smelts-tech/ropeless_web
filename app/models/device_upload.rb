class DeviceUpload < ApplicationRecord
  has_one_attached :uploaded_file
end
