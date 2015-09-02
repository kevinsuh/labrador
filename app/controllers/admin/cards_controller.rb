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
			puts @cards_data.inspect
		end

	end

end