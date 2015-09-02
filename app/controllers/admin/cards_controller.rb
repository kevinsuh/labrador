module Admin

	class CardsController < ApplicationController

		def index
			@cards_data = Hash.new

			# go through each card 
			@cards = Card.all_with_filters
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

			@filter_occasions     = []
			@filter_relationships = []
			@filter_flavors       = []

			puts @cards_data.inspect
		end

		# render same format as 'index' but with filtered data
		def filter_search

			filter_params    = params[:filters]
			if filter_params
				occasion_ids     = filter_params[:occasions]
				relationship_ids = filter_params[:relationships]
				flavor_ids       = filter_params[:flavors]
			end
			
			filters                 = Hash.new
			filters[:occasions]     = occasion_ids
			filters[:relationships] = relationship_ids
			filters[:flavors]       = flavor_ids
			
			@cards_data = Hash.new

			# go through each card 
			@cards = Card.all_with_filters filters

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

			@filter_occasions     = occasion_ids ? occasion_ids.map(&:to_i) : []
			@filter_relationships = relationship_ids ? relationship_ids.map(&:to_i) : []
			@filter_flavors       = flavor_ids ? flavor_ids.map(&:to_i) : []

			render 'index'
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
				@card.card_images.destroy_all
				@card.card_images.create(picture: picture)

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