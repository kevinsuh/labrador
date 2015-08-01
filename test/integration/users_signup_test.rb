require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
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
															 email: "kevinsuh34@gmail.com",
															 password: "kevinsuh",
															 password_confirmation: "kevinsuh"
															}
		end
		# test for success
		assert_template 'users/show'
		assert_select "div.alert-success", { :count => 1 }
	end

end
