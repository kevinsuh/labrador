class MicropostsController < ApplicationController

	before_action :require_login, only: [:create]
	before_action :correct_user, only: [:destroy]

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Sent tweet."
			redirect_to root_url
		else
			@micropost_feed = current_user.feed.paginate(page: params[:page])
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Deleted micropost"
		redirect_to request.referrer || root_url
	end

	private
		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end

		# security measure to ensure that the micropost is belonged to the user who is currently logged in
    def correct_user
    	@micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


end
