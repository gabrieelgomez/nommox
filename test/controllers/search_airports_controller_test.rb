require 'test_helper'

class SearchAirportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_airports_index_url
    assert_response :success
  end

end
