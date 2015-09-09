module AddressesHelper

	# set shipping address for orders
	def queued_orders_shipping_address=(address)
		queued_orders = Order.get_orders_for current_user.id, "queued"
		queued_orders.each do |order|
			order.set_shipping_address address
		end
		session[:checkout_address] = address.id
	end

	def checkout_address
		checkout_address = Address.find_by(id: session[:checkout_address]) || get_primary_address
	end

	def primary_address
		current_user.addresses.where(is_primary: true).limit(1).first
  end

end
