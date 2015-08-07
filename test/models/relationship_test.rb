require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
  	@relationship = relationships(:one)
  end

  test "should be valid" do
  	assert @relationship.valid?
  end

  test "follower cannot be nil" do
  	@relationship.follower = nil
  	assert_not @relationship.nil?
  end

  test "followed cannot be nil" do
  	@relationship.followed = nil
  	assert_not @relationship.nil?
  end
end
