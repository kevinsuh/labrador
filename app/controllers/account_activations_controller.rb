class AccountActivationsController < ApplicationController

  def edit
  	email = params[:email]
  	activation_token = params[:id]
  	user = User.find_by(email: email)
  	if user && !user.is_activated? && user.authenticated?(:activation, activation_token)
  		user.activate
  		log_in user
  		remember user
  		flash[:success] = "Account activated!"
  		redirect_to user
  	else
  		flash[:danger] = "Invalid activation link. For support contact support@cardagain.com."
  		redirect_to root_url
  	end
  end
  
end
