require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
  	@user = users(:kevin)
  	@micropost = @user.microposts.build(content: "user built micropost")
  	@most_recent_micropost = microposts(:most_recent_micropost)
  end

  test "micropost should be valid" do
  	assert @micropost.valid?
  end

  test "micropost should not be valid" do
  	@micropost.user_id = nil
  	assert_not @micropost.valid?
  end

  test "order should be most recent first" do
  	assert_equal Micropost.first, @most_recent_micropost
  end

  test "content should be present" do
  	content = "   "
  	@micropost.content = content
  	assert_not @micropost.valid?
  end

  test "content must be less than 140 characters" do
  	content = "a" * 141
  	@micropost.content = content
  	assert_not @micropost.valid?
  end

end
