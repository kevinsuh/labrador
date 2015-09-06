class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient
  belongs_to :card
  has_one :order_status

  # has one through order_occasions
	has_one :order_occasion
	has_one :occasion, through: :order_occasion

	belongs_to :shipping_address, class_name: "Address", foreign_key: 'shipping_address_id'
  
	class << self

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

	# persistent session via cookies
	def set_shipping_address(address)
		update_attribute(:shipping_address_id, address.id)
	end

end
