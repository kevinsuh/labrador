module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out
		if logged_in?
			forget(current_user)
			session.delete(:user_id)
			@current_user = nil
		end
	end

	def current_user
		# first tries to find via session, then by cookie
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			remember_token = cookies[:remember_token]
			if user && user.authenticated?(remember_token, user.remember_digest)
				log_in user
				@current_user = user
			end
		end
	end

	def logged_in?
		!current_user.nil?
	end

	# remember a user via cookies
	# session is used to LOGIN a user for a single use
	# cookies is to REMEMBER a user throughout multiple uses
	def remember(user)
		user.remember
		cookies.permanent[:remember_token] = user.remember_token
		cookies.permanent.signed[:user_id] = user.id
	end

	def forget(user)
		user.forget
		cookies.delete(:remember_token)
		cookies.delete(:user_id)
	end

end
