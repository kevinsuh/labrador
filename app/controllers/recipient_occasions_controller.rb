class RecipientOccasionsController < ApplicationController

	# get all saved 'recipient occasions' for current user
	def get_occasions_for_current

		recipient_ids = current_user.recipients.ids
		recipient_occasions = RecipientOccasion.where("recipient_occasions.recipient_id IN (:recipient_ids)", recipient_ids: recipient_ids)
		respond_to do |format|
  		format.json { render json: recipient_occasions }
  	end

	end

end
