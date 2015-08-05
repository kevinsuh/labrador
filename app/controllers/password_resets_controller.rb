class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	# 1. add token & digest to user
  	# 2. send email with appropriate fields
  	@user = User.find_by(email: params[:password_reset][:email])
  	if @user
  		@user.reset_password
  		@user.send_password_reset_email
  		flash[:info] = "Password reset email sent."
  		redirect_to root_url
  	else
  		flash[:danger] = "Could not find email. Please try again."
  		render 'new'
  	end
  end

  def edit
  	# get the email, and authenticate resets_digest before we render this page
  	# if we're good, then get the user object and make edits to him!
  	@user = current_user
  end

  def update
  end

end
