class Post < ActiveRecord::Base

	include FlapperNewsHelper

	has_many :comments
	has_many :post_upvotes
	belongs_to :user
	validates :user_id, presence: true


	# have our json responses include associated comments
	def as_json(options = {})
		
		post = super

		# attach user info to each post
		post[:user]     = user_info

		# has current user already upvoted content?
		if options[:current_user_id]

			# is post already upvoted?
			current_user_id = options[:current_user_id]
			post[:already_upvoted] = json_is_post_upvoted current_user_id	

			# are comments already upvoted?
			post_comments = Array.new
			comments.each_with_index do |comment, index|
				current_comment = Hash.new
				current_comment[:comment] = comment
				current_comment_id = comment.id
				current_comment[:already_upvoted] = json_is_comment_upvoted current_comment_id, current_user_id
				post_comments << current_comment
			end

			post[:comments] = post_comments

		end
	

		post

	end

end
