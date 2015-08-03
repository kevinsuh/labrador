require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:kevin)
  end
  
  test "invalid login" do 
  	get login_path
  	post login_path, session: { email: "asfklm",
  															password: "foobar"
  														}
		assert_template "sessions/new"
		assert_not flash.empty?
		get root_path
		assert flash.empty?, "flash should not persist"													
  end

  test "valid login then valid logout" do 

  	# valid login
  	get login_path
  	log_in_as(@user, password:'password', remember_me:'1')
  	assert_redirected_to @user
  	follow_redirect!
  	assert_template 'users/show'
  	assert_select "a[href=?]", logout_path
  	assert_select "a[href=?]", login_path, count: 0
  	assert_select "a[href=?]", user_path(@user)

  	# valid logout
  	delete logout_path
  	assert_not is_logged_in?
  	assert_redirected_to root_url
  	follow_redirect!
  	assert_select "a[href=?]", login_path
  	assert_select "a[href=?]", logout_path, count: 0
  	assert_select "a[href=?]", user_path(@user), count: 0

  	# try logging out again
  	delete logout_path
  	follow_redirect!
  	assert_select "a[href=?]", login_path
  	assert_select "a[href=?]", logout_path, count: 0
  	assert_select "a[href=?]", user_path(@user), count: 0

  end

  test "login with remembering" do
  	log_in_as(@user, remember_me: 1, password: 'password')
  	assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
  	log_in_as(@user, remember_me: 0, password: 'password')
  	assert_nil cookies['remember_token']
  end


end
