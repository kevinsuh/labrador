class OccasionsController < ApplicationController
  
  def get_occasions
  	# return all the occasions
  	occasions = Occasion.where.not(id: 12) # don't return the "all" option
  	respond_to do |format|
  		format.json { render json: occasions }
  	end
  end

  # get all of current_user's occasions as an array
  def get_current_occasions

  	current_occasions = Array.new
    recipients = current_user.recipients.live # only get the live recipients!

    recipients.each do |recipient|
    	current_occasions << recipient.recipient_occasions.live
    end

    respond_to do |format|
      format.json { render json: current_occasions }
    end
  end

  def occasions_for_recipients
    recipient_ids = params[:recipient_ids]
    recipient_occasions = RecipientOccasion.where("recipient_id IN (:recipient_ids)", recipient_ids: recipient_ids)
    respond_to do |format|
      format.json { render json: recipient_occasions }
    end
  end

  def create_for_current
  	
  	# get necessary params
		month        = params[:month]
		day          = params[:day]
		notes        = params[:notes]
		occasion_id  = params[:occasion_id]
		recipient_id = params[:recipient_id]
		name         = params[:name]

  	occasion = RecipientOccasion.create(
  		recipient_id: recipient_id,
  		occasion_id: occasion_id,
  		month: month,
  		day: day,
  		notes: notes,
  		name: name
  		)

    respond_to do |format|
      format.json { render json: occasion }
    end

  end

  def update_for_current

  end

  def delete_for_current

  end

  def delete_selected_occasions
  	occasion_ids = params[:occasion_ids]
    occasions = RecipientOccasion.where("id IN (:occasion_ids)", occasion_ids: occasion_ids)
    occasions.each do |occasion|
      occasion.deleted!
    end
    respond_to do |format|
      format.json { render json: occasions }
    end
  end

end
