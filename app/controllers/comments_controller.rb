class CommentsController < ApplicationController

	before_action :require_login_json, only: [:create, :upvote]

	def create

		post = Post.find(params[:post_id])
		comment = current_user.comments.create(
								comment_params.merge(
									post_id: params[:post_id]
								)
							)
		respond_with post, comment

	end

	def upvote

		post = Post.find(params[:post_id])
		comment = post.comments.find(params[:id])
		comment.increment!(:upvotes)
		respond_with post, comment

	end

	private

  	def comment_params
  		params.require(:comment).permit(:body)
  	end

	respond_to :json
end
