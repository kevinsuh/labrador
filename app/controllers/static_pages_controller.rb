class StaticPagesController < ApplicationController

  def home
  	if logged_in?
  		@micropost = current_user.microposts.build
  		@micropost_feed = current_user.feed.paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  end

  def contact_us
  end
  
end
