class AgencyUser < User

  validates :agency_name, :address, :city, :state, :zip_code, :phone_number, presence: true

  def set_access_needed
    @access_needed = "AgencyUser"
  end
end
