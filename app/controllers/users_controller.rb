class UsersController < ApplicationController

  before_action :require_login, only: [:index, :destroy, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
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

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "Successfully deleted #{user.name}"
    redirect_to users_url
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

    def admin_user
      @user = current_user
      if !@user.is_admin?
        flash[:danger] = "You do not have the access to do that."
        redirect_to root_url
      end
    end

    # tests to see that this user is the logged_in user
    # returns user if successful, false if not
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

end
