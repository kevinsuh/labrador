module PaymentCardsHelper

	# set card to be used for checkout
	def set_order_payment(card)
		session[:checkout_card] = card.id
	end

	def set_payment_billing_address(address)
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

end
