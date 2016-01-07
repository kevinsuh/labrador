module Checkout
  class AddressesController < ApplicationController

    include AddressesHelper

    def index 
      @addresses = current_user.addresses
    end

    # temp function to get all of the addresses
    def get_all_addresses
      @addresses = Address.all
      respond_to do |format|
        format.json {render json: @addresses }
      end
    end

    def new
    end

    # this creates shipping address and attaches to order
    def create

    	@address = current_user.addresses.new(address_params)
    	if @address.save

        # if just-saved address is first one, set it as default
        address_count = current_user.addresses.count
    		if @address.is_primary? || address_count == 1
    			@address.set_primary
    		end

    		# take user's queued orders and set shipping_address_id
    		self.queued_orders_shipping_address = @address

        redirect_to checkout_payment_cards_path
    	else
    		flash[:danger] = "Unable to save address."
        redirect_to checkout_addresses_path
    	end
      
    end

    # set the order's shipping address_id to the specified address
  	def set_for_order

      address_id = params[:address_id]

  		if @address = Address.find_by(id: address_id)
        # take user's queued orders and set shipping_address_id
        self.queued_orders_shipping_address = @address
        
        if current_user.stripe_account
          redirect_to checkout_final_path
        else
          redirect_to checkout_payment_cards_path
        end

      else
        flash[:danger] = "Unable to set address."
        redirect_to checkout_addresses_path
      end
  		
  	end  

  	# delete shipping address (in reality just sets visible to false)
  	def delete

      address_id = params[:address_id]
      if @address = Address.find_by(id: address_id)

        if @address.is_primary?
          flash[:danger] = "Unable to delete default shipping address."
        else
          @address.update_columns(is_visible: false)
          flash[:success] = "Successfully deleted address."
        end
        redirect_to checkout_addresses_path
      else
        flash[:danger] = "Unable to set address."
        redirect_to checkout_addresses_path
      end

  	end

    def update

      @address = Address.find_by(id: params[:id])
      if @address.update_attributes(address_params)
        if @address.is_primary?
          @address.set_primary
        end
        flash[:success] = "Address updated."
      else
        flash[:danger] = "Unable to save address."
      end
      redirect_to checkout_addresses_path

    end

    def update_json
      
      address = Address.find(params[:id])
      if address.update_attributes(address_params)
        if address.is_primary?
          address.set_primary
        end
        respond_to do |format|
          format.json { render json: address }
        end
      else
        respond_to do |format|
          format.json { render json: {address: false} }
        end
      end
      
    end

    def create_json

      address = current_user.addresses.new(address_params)
      if address.save
        # if just-saved address is first one, set it as default
        address_count = current_user.addresses.count
        if address.is_primary? || address_count == 1
          address.set_primary
        end

        respond_to do |format|
          format.json { render json: address }
        end
      else
        respond_to do |format|
          format.json { render json: {address: false} }
        end
      end

      # if address.save
      #   # take user's queued orders and set shipping_address_id
      #   self.queued_orders_shipping_address = @address

      #   redirect_to checkout_payment_cards_path
      # else
      #   flash[:danger] = "Unable to save address."
      #   redirect_to checkout_addresses_path
      # end

      

      # address = Address.find(params[:id])
      # if address.update_attributes(address_params)
      #   if address.is_primary?
      #     address.set_primary
      #   end
        
      # end
    end

    private

    	# to ensure which values we are receiving from our form
    	def address_params
    		params.require(:address).permit(:first_name, :last_name, :street, :suite, :city, :state, :zipcode, :country, :is_primary)
    	end
  end

end