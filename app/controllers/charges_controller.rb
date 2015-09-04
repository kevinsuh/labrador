# handle charges via stripe here
class ChargesController < ApplicationController

	# credit card form
	def new
		@amount = 5
	end

	# charge credit card
	def create
		flash[:success] = "You're cards have been purchased. Thank you!"
		redirect_to root_url
	end

end
