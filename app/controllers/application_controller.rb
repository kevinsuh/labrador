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

    def admin_user
      @user = current_user
      if !@user.is_admin?
        flash[:danger] = "You do not have the access to do that."
        redirect_to root_url
      end
    end

    def require_login_json
      unless logged_in?
         render json: {success: false, message: "You must be logged in!"}, status: 401
      end
    end

end
