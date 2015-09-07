module PaymentCardsHelper

	# set card to be used for checkout
	def set_order_payment(card)
		session[:checkout_card] = card.id
	end

end
