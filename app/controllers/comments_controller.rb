class CommentsController < ApplicationController

	before_action :require_login_json, only: [:create, :upvote]
	before_action :is_already_upvoted, only: [:upvote]

	def create

		post = Post.find(params[:post_id])
		comment = current_user.comments.create(
								comment_params.merge(
									post_id: params[:post_id]
								)
							)
		
		# not working...
		# comment_collection = Hash.new
		# comment_collection[:comment] = comment
		# current_comment_id = comment.id
		# comment_collection[:already_upvoted] = comment.json_is_comment_upvoted current_comment_id, current_user.id

		respond_with post, comment

	end

	def upvote

		@comment.increment!(:upvotes)
		respond_with @comment

	end

	private

  	def comment_params
  		params.require(:comment).permit(:body)
  	end

  	def is_already_upvoted

  		@comment = Comment.find(params[:id])
			user_id = current_user.id

			# you can only upvote once!
      if @comment.comment_upvotes.find_by(user_id: user_id)
        render json: {success: false, message: "You already upvoted this."}, status: 401
      else
      	@comment.comment_upvotes.create(user_id: user_id)
      end
    end

	respond_to :json
end
