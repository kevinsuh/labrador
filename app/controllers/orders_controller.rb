class OrdersController < ApplicationController

	# returns all the queued card for user (pass in parameters to determine what kind of order you want)
	# if no user_id given, assume current_user
	def orders_for_user

		order_params = params

		# default to finding current user if user_id not given
		user_id = order_params[:user_id]
		user_id ||= current_user.id

		purchased = 'f'
		delivered = 'f'
		canceled  = 'f'
		refunded  = 'f'

		if order_params[:orderType] == "purchased"
			purchased = 't'
		end

		queued_orders = Order.joins("
			LEFT JOIN `users` ON `users`.`id` = `orders`.`user_id`
			LEFT JOIN `order_statuses` ON `order_statuses`.`order_id` = `orders`.`id`").where("
			`users`.`id` = :user_id
			AND `order_statuses`.`purchased` = :purchased
			AND `order_statuses`.`delivered` = :delivered
			AND `order_statuses`.`canceled` = :canceled
			AND `order_statuses`.`refunded` = :refunded", user_id: user_id, purchased: purchased, delivered: delivered, canceled: canceled, refunded: refunded)

		respond_to do |format|
  		format.json {render json: queued_orders }
  	end

	end

end
