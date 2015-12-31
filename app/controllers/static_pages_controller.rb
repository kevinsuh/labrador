class StaticPagesController < ApplicationController

  before_action :require_login, only: [:test_angular]

  def home
  	if session[:early_access_email]
  		@early_access_email = session[:early_access_email]
  		session[:early_access_email] = nil
  	end

  end

  def help
  end

  def about
  end

  def beta_thank_you
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
