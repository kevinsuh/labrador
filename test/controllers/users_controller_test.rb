require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	
	def setup
		@user = users(:kevin)
		@second_user = users(:chip)
	end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
  	get :edit, id: @user
  	assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch :update, id: @user, user: { name: @user.name, email: @user.email }
  	assert_redirected_to login_url
  end

  test "should redirect when user gets edit page of wrong user id" do
  	log_in_as(@user) # to bypass require_login before filter
  	get :edit, id: @second_user
  	assert_redirected_to root_url
  end

  test "should redirect when user updates wrong user id" do
  	log_in_as(@user)
  	patch :update, id: @second_user, user: { name: @second_user.name, email: @second_user.email }
  	assert_redirected_to root_url
  end

  test "should redirect to login when deleting not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @second_user
    end
    assert_redirected_to login_path
  end

  test "should successfully delete if admin" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete :destroy, id: @second_user
    end
  end

  test "should prevent delete if not admin" do
    log_in_as(@second_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
  end

  test "should redirect following page when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end

  test "should redirect followers page when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end

end
