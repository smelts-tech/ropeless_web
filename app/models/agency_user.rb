class AgencyUser < User
  def set_access_needed
    @access_needed = "AgencyUser"
  end
end
