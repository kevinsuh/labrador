class Post < ActiveRecord::Base
	has_many :comments
	has_many :post_upvotes
	belongs_to :user
	validates :user_id, presence: true


	# have our json responses include associated comments
	def as_json(options = {})
		post = super
		post[:comments] = json_include_comments
		if (options[:user_id])
			post[:already_upvoted] = json_is_upvoted(options[:user_id])
			# PROBLEM: this provides the current_user from the posts controller... we need it to either provide individual user, or provide the CURRENT LOGGED IN USER then.
			# post[:user] = json_include_user_info(options[:user_id])
		end
		post
	end

	private

		# this includes comments with additional info attached
		# for now this is just user's name
		def json_include_comments
			post_comments = comments.joins(:user).where("users.id = comments.user_id").select("comments.*, users.name").as_json
		end

		# currently just includes name -- can be extended
		def json_include_user_info(user_id)
			post_id = self.id
			user_info = User.find_by_sql(["SELECT users.name FROM users WHERE users.id = :user_id LIMIT 1", user_id: user_id])[0].as_json
		end

		def json_is_upvoted(user_id)
			post_id = self.id

			already_upvoted = PostUpvote.count_by_sql(["SELECT COUNT(post_upvotes.id) FROM post_upvotes WHERE post_upvotes.post_id = :post_id AND post_upvotes.user_id = :user_id", post_id: post_id, user_id: user_id])
			already_upvoted > 0 ? true 
			: false

		end

end
