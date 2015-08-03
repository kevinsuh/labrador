require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:kevin)
	end
  
	test "invalid signup" do 
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: {  name: "",
																email: "user@invalid.com",
																password: "too",
																password_confirmation: "short"
															}
		end
		assert_template 'users/new'
	end

	test "valid signup" do
		get signup_path
		assert_difference "User.count", 1 do
			post_via_redirect users_path, user: { name: "Kevin Suh",
															 email: "testkevin@gmail.com",
															 password: "kevinsuh",
															 password_confirmation: "kevinsuh"
															}
		end

  	# should redirect to profile page
		assert_template 'users/show'
		assert_select "div.alert-success", { :count => 1 }

		# proxy to test for logged in user
		assert is_logged_in?
		assert_select "a[href=?]", logout_path
  	assert_select "a[href=?]", login_path, count: 0

	end

end
