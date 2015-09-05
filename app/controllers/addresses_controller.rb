class AddressesController < ApplicationController
  def new
  end

  def create

  	@address = current_user.addresses.new(address_params)
  	@addresses = current_user.addresses
  	if @address.save
  		flash[:success] = "Yay saved address."
  		redirect_to cart_address_path
  	else
  		flash[:danger] = "Unable to save address."
  		render 'checkout/confirm_address'
  	end

  	puts params.inspect
  end

  private

  	# to ensure which values we are receiving from our form
  	def address_params
  		params.require(:address).permit(:first_name, :last_name, :street, :suite, :city, :state, :zipcode, :is_primary)
  	end
end
