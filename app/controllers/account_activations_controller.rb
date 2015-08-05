class AccountActivationsController < ApplicationController

  def edit
  	email = params[:email]
  	activation_token = params[:id]
  	#log_in @user
      #remember @user
  		#redirect_to @user
  end
  
end
