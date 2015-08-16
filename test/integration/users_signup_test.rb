require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear # removes all emails from queue
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
		# new signup path for now
		assert_difference "User.count", 1 do post create_signup_users_path, {format: 'json', 
							user: { 	name: "Kevin Suh",
												email: "testkevin@gmail.com",
												password: "kevinsuh1",
												password_confirmation: "kevinsuh1"
											},
							address: { 
												first_name: "Kevin",
												last_name: "Suh",
												street: "7125 First St.",
												city: "Kansas City",
												state: "Kansas",
												zipcode: "1555"
							}
					}
		end

		if false
		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user) # this is because users#create defines an @user variable that we can then access
		assert_not user.is_activated?

		# try logging in before activated
		log_in_as(user)
		assert_not is_logged_in?

		# valid token, wrong email
		get edit_account_activation_url(user.activation_token, email: "wrongemail@wrongmail.com")
		assert_not is_logged_in?

		# valid activation token
		get edit_account_activation_url(user.activation_token, email: user.email)
		assert_redirected_to user
		follow_redirect!
		user.reload
		
		assert user.is_activated?
		end

		assert is_logged_in?
		# posting via JSON doesn't do any actual redirecting -- it's the angular that will based on signup-success

	end

end
