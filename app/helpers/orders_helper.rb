module OrdersHelper

	# retrieve the orders for user_id and order_type
	# order_type can be 'purchased', 'queued', etc.
	def get_orders_for(user_id, order_type)

		purchased = 'f'
		delivered = 'f'
		canceled  = 'f'
		refunded  = 'f'

		if order_type == "purchased"
			purchased = 't'
		end

		queued_orders = Order.joins("
			LEFT JOIN users ON users.id = orders.user_id
			LEFT JOIN order_statuses ON order_statuses.order_id = orders.id")
		.where("
			users.id = :user_id
			AND order_statuses.purchased = :purchased
			AND order_statuses.delivered = :delivered
			AND order_statuses.canceled = :canceled
			AND order_statuses.refunded = :refunded", user_id: user_id, purchased: purchased, delivered: delivered, canceled: canceled, refunded: refunded)

		queued_orders

	end

end
