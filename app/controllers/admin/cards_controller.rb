module Admin

	class CardsController < ApplicationController

		def index
			@cards_data = Hash.new

			# go through each card 
			@cards = Card.all_filtered
			@cards.each do |card|

				@card_data = Hash.new
				@card_data[:card] = card
				@card_data[:relationships] = card.relationships
				@card_data[:occasions] = card.occasions
				@card_data[:flavors] = card.flavors
				@card_data[:card_images] = card.card_images

				@cards_data[card.id] = @card_data
			end

			@relationships = Relationship.all
			@occasions     = Occasion.all
			@flavors       = Flavor.all

			puts @cards_data.inspect
		end

		def create

		end

		def update
			puts params

			if @card = Card.find_by(id: params[:id])
				card_params   = params[:card]

				relationships = card_params[:relationships]
				occasions     = card_params[:occasions]
				flavors       = card_params[:flavors]
				picture				= card_params[:picture]

				# purge and refresh
				@card.relationships.delete_all
				relationships.each do |relationship_id|
					@card.card_relationships.create(relationship_id: relationship_id)
				end

				@card.occasions.delete_all
				occasions.each do |occasion_id|
					@card.card_occasions.create(occasion_id: occasion_id)
				end

				@card.flavors.delete_all
				flavors.each do |flavor_id|
					@card.card_flavors.create(flavor_id: flavor_id)
				end

				# this is not what you want to do in the near future regarding pictures
				

				flash[:success] = "Card updated."
			else
				flash[:danger] = "Failed to update card."
			end
			redirect_to admin_cards_url
		end

		private

			def card_params
				params.require(:card).permit(:picture)
			end

	end
end