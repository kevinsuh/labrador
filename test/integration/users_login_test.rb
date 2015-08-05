require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:kevin)
    ActionMailer::Base.deliveries.clear # removes all emails from queue
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

  test "valid password reset path" do
    
    get new_password_reset_path
    assert_template 'password_resets/new'

    post password_resets_path, password_reset: { email: @user.email }

    user = assigns(:user)
    password_reset_token = user.password_reset_token
    email = user.email

    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert'
    assert_equal 1, ActionMailer::Base.deliveries.size

    # valid email, wrong password_reset token
    get edit_password_reset_url("wrong token", email: email)
    assert_redirected_to root_url

    # invalid email, right password_reset_token
    get edit_password_reset_url(password_reset_token, email: "wrongemail@ALKMLK.com")
    assert_redirected_to root_url

    # valid email + valid password_reset_token
    get edit_password_reset_url(password_reset_token, email: email)
    assert_template "password_resets/edit"
    assert_select "input#email[type=hidden][name=email][value=?]", email

    # invalid password reset
    patch password_reset_path(password_reset_token), { email: email,
      user: {
        password: 'wrongPass',
        password_confirmation: 'notconfirmed'
      }
    }
    assert_select "div#error_explanation"
    assert_template 'password_resets/edit'

    # valid password reset
    patch password_reset_path(password_reset_token), { email: email,
                        user: {
                          password: "newpassword",
                          password_confirmation: "newpassword"
                        }
                      }

    assert is_logged_in?, "is not logged in"
    assert_redirected_to user

  end

  test "invalid email for password reset path" do
    get new_password_reset_path
    assert_template 'password_resets/new'

    post password_resets_path, password_reset: { email: "wrongemail@wrongzemLAI.com" }
    assert_template 'password_resets/new'
    assert_not is_logged_in?

  end


end
