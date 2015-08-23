class CardsController < ApplicationController
  
	# validate, then queue card and return the successful card in JSON notation
  def queue_card
  	# 1) validate card
  	# 2) create new recipient (eventually you should also be able to CHOOSE past recipient)
  	# 3) save order & order progress onto DB
  	# 4) return queued card in json on success
  	
		card_params = params
		
		recipient = current_user.recipients.create(
			first_name: card_params[:recipientFirstName],
			last_name: card_params[:recipientLastName],
			relationship: card_params[:recipientRelationship]
			)

		if card = Card.find_by(id: card_params[:cardID])
			order = current_user.orders.create(
				recipient_id: recipient.id,
				card_id: card.id,
				recipient_arrival_date: card_params[:occasionDate]
				)

			order_status = OrderStatus.create(order_id: order.id) # by default all the statuses will be false

			respond_to do |format|
				format.json { render json: order }
			end

		else

			respond_to do |format|
				format.json { render json: { success: false } }
			end

		end

		

  end

end
