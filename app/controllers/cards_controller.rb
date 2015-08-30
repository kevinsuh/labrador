class CardsController < ApplicationController
	
	def get_flavors
  	flavor_types = Flavor.all
  	respond_to do |format|
  		format.json { render json: flavor_types }
  	end
  end

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
				recipient_arrival_date: card_params[:recipientArrivalDate]
				)

			order_status = OrderStatus.create(order_id: order.id) # by default all the order statuses will be false

			respond_to do |format|
				format.json { render json: order }
			end

		else

			respond_to do |format|
				format.json { render json: { success: false } }
			end

		end

  end

  def get_curated_cards
  	
  	card_params = params

  	occasion_id = card_params[:occasion]
  	relationship_id = card_params[:recipientRelationship]
		flavor_ids = card_params[:cardFlavors]

		# include cards that are appropriate for all relationships and occasions
		all_relationships_id = 12
		all_occasions_id     = 12

		# if flavor_ids is empty, then it means all
		if flavor_ids.nil?
			flavor_ids = Flavor.ids
		end

		# find the cards that are filtered by relationship_id, occasion_id, and contains at least one of the flavor_ids
		cards = Card.joins("
			LEFT JOIN `card_relationships`
				ON `card_relationships`.`card_id` = `cards`.`id`
			LEFT JOIN `card_occasions`
				ON `card_occasions`.`card_id` = `cards`.`id`
			LEFT JOIN `card_flavors`
				ON `card_flavors`.`card_id` = `cards`.`id`").where("
			`card_relationships`.`relationship_id` IN (:relationship_ids)
			AND `card_occasions`.`occasion_id` IN (:occasion_ids)
			AND `card_flavors`.`flavor_id` IN (:flavor_ids)", relationship_ids: [all_relationships_id, relationship_id], occasion_ids: [all_occasions_id, occasion_id], flavor_ids: flavor_ids).distinct
  	
  	respond_to do |format|
  		format.json {render json: cards }
  	end

  end

end
