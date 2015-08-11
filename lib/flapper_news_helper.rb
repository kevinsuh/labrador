module FlapperNewsHelper
	# currently just includes name -- can be extended
	def user_info
		user_id = self.user_id
		user_info = User.find_by_sql(["SELECT users.name FROM users WHERE users.id = :user_id LIMIT 1", user_id: user_id])[0]
	end

	# check if USER CURRENTLY LOGGED IN has already upvoted a post
	def json_is_post_upvoted(current_user_id)
		post_id = self.id

		already_upvoted = PostUpvote.where(post_id: post_id, user_id: current_user_id).count(:id)

		already_upvoted > 0 ? true 
		: false

	end

	def json_is_comment_upvoted(comment_id, current_user_id)
		already_upvoted = CommentUpvote.where(comment_id: comment_id, user_id: current_user_id).count(:id)
		already_upvoted > 0 ? true : false
	end

end
