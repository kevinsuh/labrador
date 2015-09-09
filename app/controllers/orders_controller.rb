class OrdersController < ApplicationController

	include OrdersHelper

	# returns all the queued card for user (pass in parameters to determine what kind of order you want)
	# if no user_id given, assume current_user
	def orders_for_user

		order_params = params

		# default to finding current user if user_id not given
		user_id = order_params[:user_id]
		user_id ||= current_user.id
		order_type = order_params[:orderType]

		queued_orders = Order.get_orders_for user_id, order_type

		if order_params[:orderType] == "purchased"
			purchased = 't'
		end

		respond_to do |format|
  		format.json {render json: queued_orders }
  	end

	end

	# validate, then queue card and return the successful card in JSON notation
  def queue_card_order
  	# 1) validate card
  	# 2) create new recipient (eventually you should also be able to CHOOSE past recipient)
  	# 3) save order & order progress onto DB
  	# 4) return queued card in json on success
  			
		recipient = current_user.recipients.create(
			first_name: params[:recipientFirstName],
			last_name: params[:recipientLastName],
			relationship_id: params[:recipientRelationship]
			)

		selected_card = params[:selectedCard]

		if card = Card.find_by(id: selected_card[:id])
			order = current_user.orders.create(
				recipient_id: recipient.id,
				card_id: card.id,
				recipient_arrival_date: params[:recipientArrivalDate]
				)

			# by default all the order statuses will be false
			order_status = OrderStatus.create(order_id: order.id) 
			order_occasion = order.create_order_occasion(occasion_id: params[:occasion])


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
