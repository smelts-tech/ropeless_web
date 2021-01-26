class Fisher < User
  validates :permit_number, :address, :city, :state, :zip_code, :phone_number, presence: true

  has_many :devices
  has_many :device_uploads, inverse_of: :fisher

  after_initialize :set_access_needed

  def set_access_needed
    @access_needed = "Fisher"
  end
end
