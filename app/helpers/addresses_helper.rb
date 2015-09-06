module AddressesHelper

	# set shipping address for orders
	def set_queued_orders_shipping(address)
		queued_orders = Order.get_orders_for current_user.id, "queued"
		queued_orders.each do |order|
			order.set_shipping_address address
		end
	end
end
