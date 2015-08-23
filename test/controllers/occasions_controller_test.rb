require 'test_helper'

class OccasionsControllerTest < ActionController::TestCase
  test "should get get_occasion_types" do
    get :get_occasion_types
    assert_response :success
  end

end
