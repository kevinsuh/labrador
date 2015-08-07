require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  
	def setup
    @kevin = users(:kevin)
    @chip  = users(:chip)
    @ben   = users(:ben)
    @emily = users(:emily)

		# follow 25 people
		25.times do |n|
			@kevin.follow(User.offset(n+10).first)
			#@kevin.active_relationships.create(followed_id: User.offset(n+10).first.id)
		end

		# get followed by 10 people
		10.times do |n|
			User.offset(n+45).first.follow(@kevin)
			#@kevin.passive_relationships.create(follower_id: User.offset(n+45).first.id)
		end
	end

  test "feed should have tweets of users im following" do
    
    # 1. no feed without login
    get root_url
    assert_select "h3", false, text: "Feed"

    log_in_as(@kevin)

    # 2. login as user, feed should appear
    get root_url
    assert_select "h3", text: "Feed"

    if (!@kevin.following?(@chip))
      @kevin.follow(@chip)
    end
    if (!@kevin.following?(@emily))
      @kevin.follow(@emily)
    end

    # 3. should see first page of tweets of my tweets, along with tweets of users i'm following
    @emily.microposts.each do |micropost|
      assert @kevin.feed.include?(micropost)
    end

    @chip.microposts.each do |micropost|
      assert @kevin.feed.include?(micropost)
    end

    # 4. if unfollowed, you should not see his tweets
    @kevin.unfollow(@chip)
    @chip.microposts.each do |micropost|
      assert_not @kevin.feed.include?(micropost)
    end

  end

  test "full process of following / unfollowing a user" do
  	# 1. can see follow/unfollow links on profile without logging in
  	get user_path(@chip)
  	assert_select 'a', url: "/users/#{@chip.id}/following"
  	assert_select 'a', url: "/users/#{@chip.id}/followers"

  	# 1b. can't see following/follower pages without logging in
  	get following_user_path(@chip)
  	assert_redirected_to login_path

  	get followers_user_path(@chip)
  	assert_redirected_to login_path

  	# 2. can't force a follow/unfollow without logging in
  	# this is not functional yet

  	# 3. should be able to see following/followers pages when logging in
  	log_in_as(@kevin)
  	get following_user_path(@chip)
  	assert_template 'users/show_follow'
  	assert_select 'title', /Following/

  	get followers_user_path(@chip)
  	assert_template 'users/show_follow'
  	assert_select 'title', /Followers/

  	# 4. should see follow link when NOT following a user
  	if (@kevin.following?(@chip))
  		@kevin.unfollow(@chip)
  	end

  	get user_path(@chip)
  	assert_select 'input', value: "Follow"

  	# 5. should see unfollow link when following a user
  	@kevin.follow(@chip)
  	get user_path(@chip)
  	assert_select 'input', value: "Unfollow"
  	
    @kevin.unfollow(@chip)
    assert_select 'input', value: "Follow"

  	# 5a. posting to follow should lead to follow
  	# 5b. posting to unfollow should lead to unfollow
  	assert_difference "@kevin.following.count", 1 do
      post relationships_path, followed_id: @chip.id
    end
    @kevin.unfollow(@chip)
    # ajax follow
    assert_difference "@kevin.following.count", 1 do
      xhr :post, relationships_path, followed_id: @chip.id
    end

    kevin_relationship = @kevin.active_relationships.find_by(followed_id: @chip.id)

    assert_difference "@kevin.following.count", -1 do
      delete relationship_path(kevin_relationship)
    end
    @kevin.follow(@chip)
    kevin_relationship = @kevin.active_relationships.find_by(followed_id: @chip.id)
    # ajax unfollow
    assert_difference "@kevin.following.count", -1 do
      xhr :delete, relationship_path(kevin_relationship)
    end

  	# 6. should see following page of user
  	get following_user_path(@kevin)
  	@kevin.following.each do |following|
  		assert_select 'a', { text: following.name, url: user_path(following) }
  	end
  	
  	# 7. should see followers page of user
  	get followers_user_path(@kevin)
  	@kevin.followers.each do |follower|
  		assert_select 'a', { text: follower.name, url: user_path(follower) }
  	end
  end
end
