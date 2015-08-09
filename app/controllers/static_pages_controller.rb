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

  def team
  end

  def why
  end

  def test_angular
    #render layout: false
  end
  
end
