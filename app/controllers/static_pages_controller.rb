class StaticPagesController < ApplicationController

  def home
  	if session[:waitlist_email]
  		@waitlist_email = session[:waitlist_email]
  		session[:waitlist_email] = nil
  	end
  end

  def help
  end

  def about
  end

  def contact_us
  end
  
end
