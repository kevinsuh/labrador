module PaymentCardsHelper

	# set card to be used for checkout
	def set_order_payment(card)
		session[:checkout_card] = card.id
	end

	def set_payment_billing_address(address)
		session[:checkout_card_billing_address] = address.id
	end

end
