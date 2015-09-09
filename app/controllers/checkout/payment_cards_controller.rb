module Checkout
	# handle charges via stripe here
	class PaymentCardsController < ApplicationController

		include PaymentCardsHelper

		# credit card form
		def new
			@amount = 5
		end

		# view credit cards and choose one
		def index

			@cards = Array.new
			@default_billing_address = default_billing_address
			
			set_payment_billing_address @default_billing_address

			# user needs customer_id in order to retrieve card info
			if stripe_account = current_user.stripe_account

				customer_id      = stripe_account.customer_id
				customer         = Stripe::Customer.retrieve(customer_id)
				@default_card_id = customer[:default_source]
				@cards           = customer[:sources][:data]

			end

			# get cards from customer id
			
			
		end

		# use this credit card for the order
		def set_for_order

			customer_id = params[:customer_id]
			card_id     = params[:card_id]
			customer    = Stripe::Customer.retrieve(customer_id)
			card        = customer.sources.retrieve(card_id)

			set_order_payment card

			redirect_to checkout_payment_cards_path

		end

		def destroy

		end


		# save credit card
		def create

			puts params.inspect

			card_token         = params[:registration][:card_token]
			authenticity_token = params[:authenticity_token]
			email              = current_user.email

			# create a stripe_account if user does not have one yet
			create_stripe_account email
			customer_id    = current_user.stripe_account.customer_id
			customer       = Stripe::Customer.retrieve(customer_id)

			card_info    = params[:payment_card]
			default_card = card_info[:default_card]

			# create card with options
			if customer.sources.create(source: card_token)
				flash[:success] = "Your card has been saved."
			else
				flash[:danger] = "Your card was unable to be saved."
			end
			
			redirect_to checkout_payment_cards_path

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to checkout_payment_cards_path

		end

	end
end