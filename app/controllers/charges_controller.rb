# handle charges via stripe here
class ChargesController < ApplicationController

	# credit card form
	def new
		@amount = 5
	end

	# charge credit card
	def create

		# amount in cents // must match up with amount from 'new' view!
		@amount = 500

		customer = Stripe::Customer.create(
			email: "testaccount@cardagain.com",
			card: params[:stripeToken]
		)

		charge = Stripe::Charge.create(
			customer: customer.id,
			amount: @amount,
			description: "Rails stripe customer test",
			currency: "usd"
		)

		# this is what saves credit card to the user
		current_user.save_stripe_customer_id(customer.id)

		flash[:success] = "You're cards have been purchased. Thank you!"
		redirect_to root_url

		rescue Stripe::CardError => e
			flash[:error] = e.message
			redirect_to new_charge_path

	end

end
