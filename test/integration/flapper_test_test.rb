require 'test_helper'

class FlapperTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "create post" do
  	
  	assert_difference "Post.count", 1 do
  		post posts_path, post: { title: "yay test title!"}, type: :json
  	end

  	assert_difference "User.count", 1 do
			post users_path, user: { name: "Kevin Suh",
															 email: "testkevin@gmail.com",
															 password: "kevinsuh",
															 password_confirmation: "kevinsuh"
															}
		end
  end
end
