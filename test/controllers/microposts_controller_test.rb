require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  
  def setup
  	@kevin = users(:kevin)
  	@chip = users(:chip)
  	@kevin_micropost = microposts(:kevin_micropost)
  	@chip_micropost = microposts(:chip_micropost)
  end

  test "user must be logged in to create micropost" do
  	assert_no_difference 'Micropost.count' do
  		post :create, micropost: { content: "test content" }
  	end
  	assert_redirected_to login_url
  end

  test "redirect for wrong user deleting micropost" do
  	log_in_as(@kevin)
  	assert_no_difference "Micropost.count" do
  		delete :destroy, id: @chip_micropost
  	end
  	assert_redirected_to root_url
  end
end
