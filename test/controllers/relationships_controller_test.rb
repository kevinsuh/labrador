require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "should get create" do
  	log_in_as(users(:kevin))
    get :create, followed_id: users(:chip).id
    assert_redirected_to users(:chip)
  end

  test "should get destroy" do
  	log_in_as(users(:kevin))
  	relationship = Relationship.first
  	followed_user = relationship.followed
    get :destroy, id: relationship.id
    assert_redirected_to followed_user
  end

end
