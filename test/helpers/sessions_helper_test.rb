require 'test_helper'
class SessionsHelperTest < ActionView::TestCase
  test "current_user" do
    user = users(:kevin)
    remember(user)
    assert_equal user, current_user
end end