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
			@total_charge     = @base_price + @shipping_charge + @tax

		end

		# purchase the cards and send back to root url!
		def submit_order

			card_id         = params[:card_id]
			customer_id     = current_user.stripe_account.customer_id
			
			orders          = current_cart
			base_price      = base_price_for orders
			shipping_charge = shipping_charge_for orders
			tax             = tax_for base_price
			total_charge    = base_price + shipping_charge + tax

			# stripe is in cents
			total_charge = (total_charge * 100).to_i

			charge = Stripe::Charge.create(
				amount: total_charge,
				currency: "usd",
				customer: customer_id,
				source: card_id,
				description: "Purchase of #{orders.count} cards from #{current_user.email}"
			)

			# more stuff if charge was successful
			if charge
				# we need to update the order status from queued => purchased
				flash[:success] = "Thank you for your purchase!."
			else
				flash[:danger] = "Your purchase was not successful."
			end
			
			redirect_to checkout_final_path

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to checkout_payment_cards_path

		end

	end
end