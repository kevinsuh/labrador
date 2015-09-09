module Checkout

	class OrdersController < ApplicationController

		include OrdersHelper
		include AddressesHelper
		include PaymentCardsHelper

		def view_cart

			# cart defined to be all of current_user's "queued" but not "purchased" cards
			@orders = current_cart

		end

		# final confirmation view before purchase
		def final_confirmation

			@orders           = current_cart
			@checkout_card    = checkout_payment_card
			@checkout_address = checkout_address

		end

		# purchase the cards and send back to root url!
		def checkout

		end

	end
end