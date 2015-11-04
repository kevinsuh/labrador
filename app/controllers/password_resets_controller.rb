class PasswordResetsController < ApplicationController

	before_action :get_user, only: [:edit, :update]

  layout "wizard_application"

  def new
  end

  def create
  	# 1. add token & digest to user
  	# 2. send email with appropriate fields
  	@user = User.find_by(email: params[:password_reset][:email])
  	if @user
  		@user.reset_password
  		@user.send_password_reset_email
  		flash.now[:info] = "Password reset email sent."
  		render 'new'
  	else
  		flash.now[:danger] = "Could not find email. Please try again."
  		render 'new'
  	end
  end

  def edit
  	# calls get_user to get user for the form
  end

  def update
  	# get user and update
  	if !@user.reset_in_time?
      flash.now[:danger] = "Password resent has expired."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(password_params)
      if (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
        flash.now[:danger] = "Password/confirmation can't be blank."
        render 'edit'
      else # successful page
        log_in @user
        remember @user
        redirect_to root_url
      end
    else
      render 'edit'
    end
  end

  private

  	# retrieve user and verifies its authenticity
  	def get_user
  		email = params[:email]
  		password_reset_token = params[:id]
  		potential_user = User.find_by(email: email)
  		if potential_user && potential_user.authenticated?(:password_reset, password_reset_token)
  			@user = potential_user
  		else
  			flash.now[:danger] = "Could not reset password. Please try again."
  			redirect_to root_url
  		end
  	end

  	def password_params
  		params.require(:user).permit(:password, :password_confirmation)
  	end

end
