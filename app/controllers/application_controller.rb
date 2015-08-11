class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper


  protected
  	def require_login
      unless logged_in?
        store_location # friendly forwarding
        flash[:danger] = "You must log in"
        redirect_to login_path
      end
    end

    def require_login_json
      unless logged_in?
         render json: {success: false, message: "You must be logged in!"}, status: 401
      end
    end
end
