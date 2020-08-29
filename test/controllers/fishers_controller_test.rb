require 'test_helper'

class FishersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get fishers_show_url
    assert_response :success
  end

end
