require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
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

  test "valid login" do 
  end

end
