class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	#debugger
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "You have signed up for cardagain!"
      log_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	# to ensure which values we are receiving from our form
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

end
