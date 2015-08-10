class CommentsController < ApplicationController

	def create
		post = Post.find(params[:id])
		comment = post.comments.create(comment_params)
		respond_with post, comment
	end

	def upvote
		post = Post.find(params[:post_id])
		comment = post.comments.find(params[:id])
		comment.upvotes++
		comment.update_attribute(upvotes: comment.upvotes)

		respond_with post, comment
		end
	end

	private

  	def comment_params
  		params.require(:comment).permit(:body)
  	end

	respond_to :json
end
