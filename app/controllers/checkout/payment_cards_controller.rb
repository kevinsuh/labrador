module Checkout
	# handle charges via stripe here
	class PaymentCardsController < ApplicationController

		include PaymentCardsHelper

		# credit card form
		def new
			@amount = 5
		end

		# view credit cards and choose one
		def index

			@cards = Array.new
			@default_billing_address = default_billing_address
			
			self.checkout_card_billing_address = @default_billing_address

			# user needs customer_id in order to retrieve card info
			if stripe_account = current_user.stripe_account

				customer_id      = stripe_account.customer_id
				customer         = Stripe::Customer.retrieve(customer_id)
				@default_card_id = customer[:default_source]
				@cards           = customer[:sources][:data]

			end

			# get cards from customer id
			
			
		end

		# use this credit card for the order
		def set_for_order

			customer_id = params[:customer_id]
			card_id     = params[:card_id]
			customer    = Stripe::Customer.retrieve(customer_id)

			if card = customer.sources.retrieve(card_id)
				self.checkout_card = card
				redirect_to checkout_final_path
			else
				flash[:danger] = "Unable to set card."
        redirect_to checkout_payment_cards_path
			end

		end

		def destroy

		end

		def update_json

			card_params = params[:payment_card]

			card_id    = card_params[:id]
			
			# updatable fields
			name       = card_params[:name]
			exp_month  = card_params[:exp_month]
			exp_year   = card_params[:exp_year]
			is_primary = card_params[:is_primary]

			if stripe_account = current_user.stripe_account

				customer_id = stripe_account.customer_id
				customer    = Stripe::Customer.retrieve(customer_id)
				card        = customer.sources.retrieve(card_id)

				card.name      = name
				card.exp_month = exp_month
				card.exp_year  = exp_year
				card.save

				if is_primary
					customer.default_source = card_id
					customer.save
				end

				respond_to do |format|
					format.json { render json: { payment: card } }
				end

			else
				respond_to do |format|
          format.json { render json: { payment: false } }
        end
			end
      
    end

		# update via stripe
		def update_card

			card_params = params[:card]
			card_id     = card_params[:id]
			card_name   = card_params[:name]
			exp_month   = card_params[:exp_month]
			exp_year    = card_params[:exp_year]
			is_default  = card_params[:default_card] == "1" ? true : false

			if stripe_account = current_user.stripe_account

				customer_id = stripe_account.customer_id
				customer    = Stripe::Customer.retrieve(customer_id)
				card        = customer.sources.retrieve(card_id)

				card.name      = card_name
				card.exp_month = exp_month
				card.exp_year  = exp_year
				card.save

				if is_default
					customer.default_source = card_id
					customer.save
				end

				flash[:success] = "Card updated."

			else
				flash[:danger] = "You do not have a card to update."
			end

			redirect_to checkout_payment_cards_path

		end

		# save credit card via json
		def create_json
			puts params.inspect

			stripe_token = params[:stripe_token]
			email = current_user.email

			# create a stripe_account if user does not have one yet
			create_stripe_account email
			customer_id    = current_user.stripe_account.customer_id
			customer       = Stripe::Customer.retrieve(customer_id)

			# create card with options
			if customer.sources.create(source: stripe_token)
				respond_to do |format|
          format.json { render json: { payment: true } }
        end
			else
				respond_to do |format|
          format.json { render json: { payment: false } }
        end
			end

			rescue Stripe::CardError => e
				respond_to do |format|
          format.json { render json: { payment: false, message: e.message } }
        end

		end


		# save credit card
		def create

			puts params.inspect

			card_token         = params[:registration][:card_token]
			authenticity_token = params[:authenticity_token]
			email              = current_user.email

			# create a stripe_account if user does not have one yet
			create_stripe_account email
			customer_id    = current_user.stripe_account.customer_id
			customer       = Stripe::Customer.retrieve(customer_id)

			card_info    = params[:payment_card]
			default_card = card_info[:default_card]

			# create card with options
			if customer.sources.create(source: card_token)
				flash[:success] = "Your card has been saved."
			else
				flash[:danger] = "Your card was unable to be saved."
			end
			
			redirect_to checkout_payment_cards_path

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to checkout_payment_cards_path

		end

	end
end