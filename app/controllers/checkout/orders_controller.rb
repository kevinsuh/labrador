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
			
			@base_price       = base_price_for @orders
			@shipping_charge  = shipping_charge_for @orders
			@tax              = tax_for @base_price
			@total_charge = @base_price + @shipping_charge + @tax

		end

		# purchase the cards and send back to root url!
		def checkout

		end

	end
end