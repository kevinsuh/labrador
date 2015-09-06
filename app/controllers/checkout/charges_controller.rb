module Checkout
	# handle charges via stripe here
	class ChargesController < ApplicationController

		# credit card form
		def new
			@amount = 5
		end

		# charge credit card
		def create

			# amount in cents // must match up with amount from 'new' view!
			@amount            = 750
			card_token         = params[:registration][:card_token]
			authenticity_token = params[:authenticity_token]

			# 1. charge card
			# 2. save card info
			# 3. save shipping address + billing address
			email = current_user.email

			customer = Stripe::Customer.create(
				email: "testaccount@cardagain.com",
				card: card_token
			)

			# customer_id is the persistent card identifier
			charge = Stripe::Charge.create(
				customer: customer.id,
				amount: @amount,
				description: "New stripe.js test wtih rails",
				currency: "usd"
			)

			# this is what saves credit card to the user
			current_user.save_stripe_customer_id(customer.id)

			flash[:success] = "You're cards have been purchased. Thank you!"
			redirect_to new_charge_path

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to new_charge_path

		end

	end
end