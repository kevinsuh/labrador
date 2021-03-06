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

    if @user.is_activated? || true # right now we arent handling account_activation
      respond_to do |format|
        format.html
        format.json {render json: @user }
      end
    else 
      redirect_to root_url
    end
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

  # update users from angular post
  def update_json

    user_id      = params[:id]
    first_name   = params[:first_name]
    last_name    = params[:last_name]
    email        = params[:email]
    birth_month  = params[:birth_month]
    birth_day    = params[:birth_day]
    birth_year   = params[:birth_year]
    phone_number = params[:phone_number]

    # update basic attributes first
    user = User.find(user_id)
    user.update_attributes(
      first_name: first_name,
      last_name: last_name,
      email: email,
      birth_month: birth_month,
      birth_day: birth_day,
      birth_year: birth_year,
      phone_number: phone_number
    )

    # delete all addresses then insert
    user.addresses.destroy_all
    if addresses = params[:addresses]
      addresses.each do |address|

        street = address[:street]
        suite = address[:suite]
        city = address[:city]
        state = address[:state]
        zipcode = address[:zipcode]
        is_primary = address[:is_primary]

        address = user.addresses.create(
          first_name: first_name,
          last_name: last_name,
          street: street,
          suite: suite,
          city: city,
          state: state,
          zipcode: zipcode,
          is_primary: is_primary
          )
        if is_primary
          address.set_primary
        end
      end
    end 

    respond_to do |format|
      format.json { render json: user }
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

  # start early access
  def start_early_access
    @early_access_email = Waitlist.new(early_access_params) # this helps you determine valid email signups
    if @early_access_email.save
      render 'new'
    else
      flash[:warning] = "Are you sure you put a valid email address?"
      redirect_to root_url
    end
  end

  def get_current_user

    if logged_in?
      user = current_user
      respond_to do |format|
        format.json {render json: user }
      end
    else
      respond_to do |format|
        format.json {render json: {status: { logged_in: false}} } 
      end
    end
  end

  # labrador sign up
  
  # validate email + pass from backend
  # this needs to be refactored into a method that creates user with:
  # 1. first / last name
  # 2. phone number
  # 3. mailing address
  # 4. username
  # 5. password
  # CURRENTLY ONLY DOES NAME / EMAIL / PASSWORD...
  
  def basic_signup

    first_name            = params[:first_name]
    last_name             = params[:last_name]
    email                 = params[:email]
    username              = params[:username]
    password              = params[:password]
    password_confirmation = params[:password_confirmation]

     # only validations currently are unique email and password validations
    user = User.new(
      first_name:             first_name,
      last_name:              last_name,
      email:                  email,
      username:               username,
      password:               password, 
      password_confirmation:  password_confirmation
      )

    if user.valid?
      user.save
    end

    respond_to do |format|
      format.json {render json: user }
    end

  end

  def advanced_signup 

    # get the user by email then create update
    email                 = params[:email]
    phone_number          = params[:phone_number]
    
    birth_day             = params[:birth_day]
    birth_month           = params[:birth_month]
    birth_year            = params[:birth_year]
    
    address               = params[:address]
    street                = address[:street]
    suite                 = address[:suite]
    city                  = address[:city]
    state                 = address[:state]
    zipcode               = address[:zipcode]

    if user = User.find_by(email: email)

      first_name = user.first_name
      last_name  = user.last_name

      user.update_columns(
        phone_number:           phone_number,
        birth_day:              birth_day,
        birth_month:            birth_month,
        birth_year:             birth_year 
      )

      address = user.addresses.build(
        first_name: first_name,
        last_name:  last_name,
        street:     street,
        suite:      suite,
        city:       city,
        state:      state,
        zipcode:    zipcode
       )
      address.save      

      user.activate

      # holding off on logging in user for now
      if false
        log_in user
        remember user        
      end

      # send reminder email
      user.send_early_access_signup_email

    end
    
    respond_to do |format|
      format.json {render json: user }
    end
    
  end

  private

  	# to ensure which values we are receiving from our form
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end

    def waitlist_params
      params.require(:waitlist).permit(:email)
    end

    def early_access_params
      params.require(:early_access).permit(:email)
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


# # POTENTIAL WAY TO INSERT / UPDATE ADDRESSES WITHOUT HAVING TO DELETE THEM ALL

# user_addresses = user.addresses

# # iterate through each of the passed in addresses
# # if user address is not in there, then delete it!
# user_addresses.each do |user_address|

#   address_id = user_address.id
#   address_exists = false
#   addresses.each do |address|
#     if address[:id] == address_id
#       address_exists = true
#     end
#   end

#   unless address_exists
#     user_address.destroy
#   end
# end
# # create or update with the remaining addresses

# addresses.each do |address|

#   street = address[:street]
#   suite = address[:suite]
#   city = address[:city]
#   state = address[:state]
#   zipcode = address[:zipcode]
#   is_primary = address[:is_primary]
  
#   # update
#   if address_id = address[:id]
#     address = Address.find(address_id)
#     address.update_attributes(
#       first_name: first_name,
#       last_name: last_name,
#       street: street,
#       suite: suite,
#       city: city,
#       state: state,
#       zipcode: zipcode,
#       is_primary: is_primary
#     )
#   else
#   # create
#     address.create(
#       first_name: first_name,
#       last_name: last_name,
#       street: street,
#       suite: suite,
#       city: city,
#       state: state,
#       zipcode: zipcode,
#       is_primary: is_primary
#     )
#   end
# end
