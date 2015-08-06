require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:kevin)
  	@second_user = users(:chip)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	patch user_path(@user), user: { name: "",
  																	email: "ksuhh,@mail.com",
  																	password: "password",
  																	password_confirmation: "password"
  																}
  	assert_template "users/edit"
  end

  test "successful edit" do

  	# before log_in
  	get edit_user_path(@user)
  	assert_redirected_to login_path
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user) # this will happen with friendly forwarding
  	follow_redirect!

  	name = "Michael Jordan"
  	email = "mj@dinnerlab.com"
  	patch user_path(@user), user: { name: name,
  																	email: email,
  																	password: "",
  																	password_confirmation: ""
  																}
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
  	assert_select "div.alert-success", { :count => 1 }
  	@user.reload #updates data
  	assert_equal @user.name, name, "User name not updated"
  	assert_equal @user.email, email, "User email not updated"
  end

end
