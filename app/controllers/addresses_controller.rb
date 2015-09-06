class AddressesController < ApplicationController

  include AddressesHelper

  def new
  end

  # normal just create address method
  def create
  end

  # this creates shipping address and attaches to order
  def create_with_order

  	@address = current_user.addresses.new(address_params)
  	if @address.save

  		if @address.is_primary?
  			@address.set_primary
  		end

  		# take user's queued orders and set shipping_address_id
  		set_queued_orders_shipping @address

  		flash[:success] = "Yay saved address."
      redirect_to cart_address_path
  	else
  		flash[:danger] = "Unable to save address."
      redirect_to cart_address_path
  	end
    
  end

  # set the order's shipping address_id to the specified address
	def set_for_order

    address_id = params[:address_id]

		if @address = Address.find_by(id: address_id)
      # take user's queued orders and set shipping_address_id
      set_queued_orders_shipping @address
      flash[:success] = "Yay saved address."
      redirect_to cart_address_path
    else
      flash[:danger] = "Unable to set address."
      redirect_to cart_address_path
    end
		
	end  

  private

  	# to ensure which values we are receiving from our form
  	def address_params
  		params.require(:address).permit(:first_name, :last_name, :street, :suite, :city, :state, :zipcode, :is_primary)
  	end
end
