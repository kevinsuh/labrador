class RecipientsController < ApplicationController
  	
  # get all of current_user's recipients
  def get_current_recipients
    recipients = current_user.recipients
    respond_to do |format|
      format.json { render json: recipients }
    end
  end

end
