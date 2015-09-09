module OrdersHelper

	def current_cart
		user_id = current_user.id
		order_type = "queued"
		Order.get_orders_for user_id, order_type
	end

	def get_checkout_payment_card

	end

end
