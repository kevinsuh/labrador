module Checkout

	class OrdersController < ApplicationController

		def view_cart

			# 1. get all the orders for user and display
			user_id = current_user.id
			order_type = "queued"
			@orders = Order.get_orders_for user_id, order_type

		end

	end
end