class UsersController < ApplicationController

  before_action :require_login, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
      remember @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Account updated."
      redirect_to @user
    else
      flash[:danger] = "Failed to update account."
      render 'edit'
    end
  end

  private

  	# to ensure which values we are receiving from our form
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def require_login
      unless logged_in?
        store_location # friendly forwarding
        flash[:danger] = "You must log in"
        redirect_to login_path
      end
    end

    # tests to see that this user is the logged_in user
    # returns user if successful, false if not
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

end
