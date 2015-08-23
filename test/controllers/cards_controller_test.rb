require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  test "should get queue_card" do
    get :queue_card
    assert_response :success
  end

end
