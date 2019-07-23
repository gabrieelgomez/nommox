require 'test_helper'

class CarouselConfigurationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carousel_configuration_index_url
    assert_response :success
  end

end
