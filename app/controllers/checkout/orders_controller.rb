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

		# stripe purchase cards in json fashion
		def submit_order_json

			shipping_address_id = params[:shipping_address_id]
			payment_id          = params[:payment_id]
			order_ids           = params[:order_ids]
			customer_id         = current_user.stripe_account.customer_id
			
			# currently, $5 includes tax + shipping
			# stripe is in cents
			total_charge = ((order_ids.count * 5) * 100).to_i

			charge = Stripe::Charge.create(
				amount: total_charge,
				currency: "usd",
				customer: customer_id,
				source: payment_id,
				description: "Purchase of #{order_ids.count} cards from #{current_user.email}. Order IDs: #{order_ids}"
			)

			# more stuff if charge was successful
			if charge
				orders = Order.where("id IN (:order_ids)", order_ids: order_ids)
				# we need to update the order status from queued => purchased
				orders.each do |order|
					order.status.update_columns(purchased: true)
				end

				respond_to do |format|
	        format.json { render json: { success: true, order_ids: order_ids } }
	      end

			else

				respond_to do |format|
	        format.json { render json: { success: false } }
	      end

			end

			rescue Stripe::CardError => e
				respond_to do |format|
          format.json { render json: { success: false, message: e.message } }
        end

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
				orders.each do |order|
					order.status.update_columns(purchased: true)
				end
				flash[:success] = "Thank you for your purchase!"
				redirect_to root_url
			else
				flash[:danger] = "Your purchase was not successful."
				redirect_to checkout_final_path
			end
			
			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to checkout_payment_cards_path

		end

	end
end