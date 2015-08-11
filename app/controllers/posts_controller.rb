class PostsController < ApplicationController

	before_action :require_login_json, only: [:create, :upvote]
	before_action :is_already_upvoted, only: [:upvote]

	def index
		
		# this should be done at model level, as with finding user in create. for each one, we need to be able to identify USER NAME OF THE USER THAT JUST CREATED THIS -- SHOULDNT BE THAT HARD.
		posts = Post.joins(:user).where("users.id = posts.user_id").select("posts.*, users.name")

		user_id = current_user.id

		respond_with posts, user_id: user_id
	end

	def create
		post = current_user.posts.create(post_params)

		# return post with updated info
		# post_id = post.id
		# user_id = post.user_id
		# updated_post = Post.find_by_sql(["SELECT posts.*, users.name FROM posts INNER JOIN users ON posts.user_id = users.id WHERE posts.id = :post_id AND posts.user_id = :user_id LIMIT 1", post_id: post_id, user_id: user_id])

		respond_with post, user_id: current_user.id
	end

	def show
		post_id = params[:id]
		post = Post.find(post_id)
		respond_with post
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
