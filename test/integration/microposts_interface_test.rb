require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@kevin = users(:kevin)
		@chip = users(:chip)
		@kevin_micropost = microposts(:kevin_micropost)
		@chip_micropost = microposts(:chip_micropost)
	end
  
  test "micropost interface with invalid and valid attempts" do

  	# home page without logging in
  	get root_url
  	assert_match "Sign up", response.body

  	# attempt to post micropost without logging in
  	post microposts_path, micropost: { content: "valid content "}
  	assert_redirected_to login_url

  	# login, then see updated home page
  	log_in_as @kevin
  	assert_redirected_to @kevin

  	get root_path
  	assert_match "view my profile", response.body
  	assert_select "div.pagination"
  	assert_select "input[type=file]"
  	 
  	# post invalid micropost (too long or blank)
  	assert_no_difference "Micropost.count" do 
  		post microposts_path, micropost: { content: "" }
  	end
  	assert_template 'static_pages/home'
  	assert_select "div#error_explanation"

  	assert_no_difference "Micropost.count" do
  		post microposts_path, micropost: { content: "a"*150 }
  	end
  	assert_template 'static_pages/home'

  	# post valid micropost and see the update
  	picture = fixture_file_upload('test/fixtures/github_robot.jpg', 'image/jpg')
  	assert_difference "Micropost.count", 1 do
  		post microposts_path, micropost: { content: "valid content", picture: picture }
  	end
  	micropost = assigns(:micropost)
  	assert micropost.picture?
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_match "valid content", response.body

  	# attempt invalid delete of micropost (someone else's micropost)
  	assert_no_difference "Micropost.count" do
  		delete micropost_path(@chip_micropost)
  	end
  	assert_redirected_to root_url
  	
  	# attempt valid delete of micropost and see the update
  	assert_difference "Micropost.count", -1 do
  		delete micropost_path(@kevin_micropost)
  	end
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_no_match @kevin_micropost.content, response.body

  	# visit another user
  	get user_path(@chip)
  	assert_select 'a', { text: "delete", count: 0 }

  end
end
