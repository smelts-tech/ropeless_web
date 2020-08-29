require 'test_helper'

class DeviceUploadControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get device_upload_new_url
    assert_response :success
  end

  test "should get create" do
    get device_upload_create_url
    assert_response :success
  end

  test "should get index" do
    get device_upload_index_url
    assert_response :success
  end

end
