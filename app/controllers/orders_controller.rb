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

		queued_orders = get_orders_for user_id, order_type

		if order_params[:orderType] == "purchased"
			purchased = 't'
		end

		respond_to do |format|
  		format.json {render json: queued_orders }
  	end

	end

end
