require 'test_helper'

class SmtpSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get smtp_settings_index_url
    assert_response :success
  end

  test "should get update" do
    get smtp_settings_update_url
    assert_response :success
  end

end
