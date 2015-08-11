class PostsController < ApplicationController

	before_action :require_login_json, only: [:create, :upvote]
	before_action :is_already_upvoted, only: [:upvote]

	def index
		
		posts = Post.all
		respond_with posts, current_user_id: current_user.id

	end

	def create
		post = current_user.posts.create(post_params)
		respond_with post, current_user_id: current_user.id
	end

	def show
		post_id = params[:id]
		post = Post.find(post_id)
		respond_with post, current_user_id: current_user.id
	end

	def upvote

		@post.increment!(:upvotes)
		respond_with @post

	end

	private

  	def post_params
  		params.require(:post).permit(:title, :link, :is_upvoted)
  	end

  	def is_already_upvoted

  		@post = Post.find(params[:id])
			user_id = current_user.id

			# you can only upvote once!
      if @post.post_upvotes.find_by(user_id: user_id)
        render json: {success: false, message: "You already upvoted this."}, status: 401
      else
      	@post.post_upvotes.create(user_id: user_id)
      end
    end

	respond_to :json
end
