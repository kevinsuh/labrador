require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "should get get_relationship_types" do
    get :get_relationship_types
    assert_response :success
  end

end
