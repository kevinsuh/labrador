class UsersController < ApplicationController

  before_action :require_login, only: [:index, :destroy, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  include StaticPagesHelper

  def new
  	@user = User.new
    render layout: "signup_application"
  end

  def show
  	@user = User.find(params[:id])
    redirect_to root_url and return unless @user.is_activated?
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 20).where(is_activated: true)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save

      # won't be doing activation for now
      @user.activate
      log_in @user
      remember @user
      flash[:success] = "You have been successfully signed up."

      # for now, let's put them right to the angular app :)
      redirect_to test_angular_path

      if false
      # handle account activation & send email
      @user.send_activation_email
  		flash[:info] = "An email has been sent to verify your account."
      end

      #redirect_to root_url
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

  # save to waitlist DB
  def add_to_waitlist
    @waitlist = Waitlist.new(waitlist_params)
    if @waitlist.save
      flash[:success] = "Yay! You have been added to the waitlist."
    else
      flash[:warning] = "Are you sure you put a valid email address?"
      session[:waitlist_email] = @waitlist.email
    end
    redirect_to root_url
  end


  # cardagain sign up
  
  # email & password generation
  def create_basic

  end

  # address for user
  def create_address

  end

  # curated content
  def create_interests

  end

  private

  	# to ensure which values we are receiving from our form
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def waitlist_params
      params.require(:waitlist).permit(:email)
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

    # test to see if user is activated before doing all this other stuff
    def is_activated
      unless current_user.is_activated?
        flash[:danger] = "You must first activate your account"
        redirect_to root_url
      end
    end

end
