class SessionsController < ApplicationController
  
  # login form
  def new
  end

  # login
  def create

		email    = params[:session][:email]
		password = params[:session][:password]

		user = User.find_by(email: email.downcase)
		if (user && user.authenticate(password))
			if user.is_activated?
				log_in user
				params[:session][:remember_me] == '1' ? remember(user) : forget(user)
				redirect_back_or root_url
			else
				flash[:warning] = "Please activate your account before logging in."
				redirect_to root_url
			end
		else
			flash.now[:danger] = "Invalid email/password combination"
			render 'new'
		end
  end

  # logout
  def destroy
  	log_out
  	redirect_to root_url
  end

  def logout_angular
  	log_out
  	respond_to do |format|
			format.json {render json: {success: true} } 
		end
  end

end
