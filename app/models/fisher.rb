class Fisher < ApplicationRecord
  has_many :devices
  has_many :device_uploads, inverse_of: :fisher
end
