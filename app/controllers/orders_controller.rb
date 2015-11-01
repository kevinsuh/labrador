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

	def get_selected_orders
    
    selected_order_ids = params[:selected_order_ids]
    selected_orders = Order.where("id IN (:order_ids)", order_ids: selected_order_ids)

    respond_to do |format|
      format.json {render json: selected_orders }
    end

  end

	# validate, then queue card and return the successful card in JSON notation
  def queue_card_order
  	
  	# only queue card if
  	# 1. card is found in DB
  	# 2. recipients are found in db AND belong to the current user

		recipients             = params[:selected_recipients]
		selected_card          = params[:selected_card]
		occasion_id            = params[:occasion_id]
		recipient_arrival_date = params[:recipient_arrival_date]

		success = true
		orders = Array.new

		if card = Card.find_by(id: selected_card[:id])

			recipients.each do |recipient|
				# we need to find recipient for the current user
				if user_recipient = current_user.recipients.find_by(id: recipient[:id])

					# currently we are defaulting pre-address if you have an address saved. but this will be an option very soon 10/11/15
					if address = user_recipient.addresses.first
						pre_address = true
						address_id = address.id
					else
						pre_address = false
						address_id = nil
					end

					order = current_user.orders.create(
						recipient_id: user_recipient.id,
						card_id: card.id,
						recipient_arrival_date: recipient_arrival_date,
						pre_address: pre_address,
						shipping_address_id: address_id)

					# by default all the order statuses will be false
					order_status = OrderStatus.create(
						order_id: order.id) 
					order_occasion = order.create_order_occasion(
						occasion_id: occasion_id)

					orders << order

				else
					success = false
				end

			end
		else
			success = false
		end

		if success
			respond_to do |format|
				format.json { render json: { data: orders } }
			end
		else
			respond_to do |format|
				format.json { render json: { success: false } }
			end
		end

	end
end
