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
			
			self.payment_billing_address = @default_billing_address

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

			self.order_payment = card

			redirect_to checkout_final_path

		end

		def destroy

		end

		# update via stripe
		def update_card

			card_params = params[:card]
			card_id     = card_params[:id]
			card_name   = card_params[:name]
			exp_month   = card_params[:exp_month]
			exp_year    = card_params[:exp_year]
			is_default  = card_params[:default_card] == "1" ? true : false

			if stripe_account = current_user.stripe_account

				customer_id = stripe_account.customer_id
				customer    = Stripe::Customer.retrieve(customer_id)
				card        = customer.sources.retrieve(card_id)

				card.name      = card_name
				card.exp_month = exp_month
				card.exp_year  = exp_year
				card.save

				if is_default
					customer.default_source = card_id
					customer.save
				end

				flash[:success] = "Card updated."

			else
				flash[:danger] = "You do not have a card to update."
			end

			redirect_to checkout_payment_cards_path

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