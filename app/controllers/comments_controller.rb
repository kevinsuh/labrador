class CommentsController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		comment = post.comments.create(comment_params)
		respond_with post, comment
	end

	def upvote
		post = Post.find(params[:post_id])
		comment = post.comments.find(params[:id])
		upvote = comment.upvotes + 1
		comment.update_attribute(:upvotes, upvote)
		respond_with post, comment
	end

	private

  	def comment_params
  		params.require(:comment).permit(:body)
  	end

	respond_to :json
end
