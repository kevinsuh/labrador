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
		else
			flash.now[:danger] = "Invalid email/password combination"
			render 'new'
		end
  end

  # logout
  def destroy
  end

end
