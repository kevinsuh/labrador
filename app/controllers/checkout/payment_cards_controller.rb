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
			@default_billing_address = Address.find_by(id: session[:checkout_address]) || current_user.addresses.where(is_primary: true).limit(1)

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

			if stripe_account = current_user.stripe_account
				customer_id = stripe_account.customer_id
			else
				# need to create new account
				stripe_account = Stripe::Customer.create(
					email: email,
					card: card_token
				)
				puts "in new account!!"
				customer_id = stripe_account.id
				current_user.save_stripe_account customer_id
			end

			puts customer_id





			# # 1. charge card
			# # 2. save card info
			# # 3. save shipping address + billing address
			# email = current_user.email

			# customer = Stripe::Customer.create(
			# 	email: "testaccount@cardagain.com",
			# 	card: card_token
			# )

			# # customer_id is the persistent card identifier
			# charge = Stripe::Charge.create(
			# 	customer: customer.id,
			# 	amount: @amount,
			# 	description: "New stripe.js test wtih rails",
			# 	currency: "usd"
			# )

			# # this is what saves credit card to the user
			# current_user.save_stripe_customer_id(customer.id)

			flash[:success] = "You're cards have been purchased. Thank you!"
			redirect_to checkout_payment_cards_path

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to checkout_payment_cards_path

		end

	end
end