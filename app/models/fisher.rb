class Fisher < User
  validates :full_name, presence: true
  validates :permit_number, presence: true

  has_many :devices
  has_many :device_uploads, inverse_of: :fisher
end
