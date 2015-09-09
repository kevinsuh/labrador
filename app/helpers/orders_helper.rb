module OrdersHelper

	def current_cart
		user_id = current_user.id
		order_type = "queued"
		Order.get_orders_for user_id, order_type
	end

	# get the base price for your order
	def base_price_for(orders)
		price = 5 * orders.count
		price
	end

	# get the shipping costs for your order
	def shipping_charge_for(orders)
		shipping_charge = 1.15 * orders.count
		shipping_charge
	end

	# get the tax for your order
	def tax_for(base_price)
		tax = 0.09 * base_price
		tax
	end

end
