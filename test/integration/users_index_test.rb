require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:kevin)
  	@nonadmin_user = users(:chip)
  end

  test "index including pagination" do
  	
  	get users_path
  	assert_redirected_to login_path

  	log_in_as(@user)
  	get users_path
  	assert_select 'div.pagination'
  	User.paginate(page: 1, per_page: 20).each do |user|
  		assert_select "a", user.name
  	end

  	# test delete
  	first_user = User.paginate(page: 1, per_page: 20).first
  	assert_difference 'User.count', -1 do
  		delete user_path(first_user)
  	end
  end

  # if non-admin, should not see any delete options
  test "index as non-admin" do
  	log_in_as(@nonadmin_user)
  	get users_path
  	assert_select 'a', text: 'delete', count: 0
  end

end
