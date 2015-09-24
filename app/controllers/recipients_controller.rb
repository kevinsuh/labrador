class RecipientsController < ApplicationController
  	
  # get all of current_user's recipients
  def get_current_recipients
    recipients = current_user.recipients
    respond_to do |format|
      format.json { render json: recipients }
    end
  end

  # create new recipient for current user
  def create_for_current
    puts params.inspect
  end

  # update recipient for current user
  def update_for_current
    puts params.inspect
  end

end
