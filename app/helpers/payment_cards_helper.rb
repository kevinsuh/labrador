module PaymentCardsHelper

	# set card to be used for checkout
	def checkout_card=(card)
		session[:checkout_card] = card.id
	end

	def checkout_card_billing_address=(address)
		session[:checkout_card_billing_address] = address.id
	end

	def default_billing_address
		Address.find_by(id: session[:checkout_address]) || current_user.addresses.where(is_primary: true).limit(1).first
	end

	def create_stripe_account(email)

		unless current_user.stripe_account
			stripe_account = Stripe::Customer.create(
				email: email
				)
			customer_id = stripe_account.id
			current_user.save_stripe_account customer_id
		end

	end

	def checkout_payment_card

		if stripe_account = current_user.stripe_account

			customer_id = stripe_account.customer_id
			customer    = Stripe::Customer.retrieve(customer_id)
			card_id     = session[:checkout_card] || customer.default_source

			customer.sources.retrieve(card_id)
		else
			flash[:warning] = "Please add or select a card."
			redirect_to checkout_payment_cards_path
		end
	end

end
