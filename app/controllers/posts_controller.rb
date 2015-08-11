class PostsController < ApplicationController

	before_action :require_login_json, only: [:create, :upvote]

	def index
		@posts = Post.all
		respond_with @posts
	end

	def create
		respond_with Post.create(post_params)
	end

	def show
		respond_with Post.find(params[:id])
	end

	def upvote

		post = Post.find(params[:id])
		post.increment!(:upvotes)
		respond_with post

	end

	private

  	def post_params
  		params.require(:post).permit(:title, :link)
  	end

	respond_to :json
end
