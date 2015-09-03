module Admin

	class CardsController < ApplicationController

		def index

			filter_params    = params[:filters]
			if filter_params
				occasion_ids     = filter_params[:occasions]
				relationship_ids = filter_params[:relationships]
				flavor_ids       = filter_params[:flavors]
				vendor_ids       = filter_params[:vendors]
			end
			
			filters                 = Hash.new
			filters[:occasions]     = occasion_ids
			filters[:relationships] = relationship_ids
			filters[:flavors]       = flavor_ids
			filters[:vendors]				= vendor_ids
			
			# go through each card to attach all relevant info
			@cards_data = Hash.new
			@cards = Card.all_with_filters filters

			@cards.each do |card|

				@card_data = Hash.new
				@card_data[:card]          = card
				@card_data[:relationships] = card.relationships
				@card_data[:occasions]     = card.occasions
				@card_data[:flavors]       = card.flavors
				@card_data[:card_images]   = card.card_images
				@card_data[:vendor]        = card.vendor
				@card_data[:card_vendor]   = card.card_vendor # contains vendor URL

				@cards_data[card.id] = @card_data
			end

			@relationships = Relationship.all
			@occasions     = Occasion.all
			@flavors       = Flavor.all
			@vendors			 = Vendor.all

			@filter_occasions     = occasion_ids ? occasion_ids.map(&:to_i) : []
			@filter_relationships = relationship_ids ? relationship_ids.map(&:to_i) : []
			@filter_flavors       = flavor_ids ? flavor_ids.map(&:to_i) : []
			@filter_vendors       = vendor_ids ? vendor_ids.map(&:to_i) : []

			puts @cards_data.inspect
		end

		def new
			@card          = Card.new
			@relationships = Relationship.all
			@occasions     = Occasion.all
			@flavors       = Flavor.all
			@vendors       = Vendor.all
		end

		def create
			card_params   = params[:card]
			vendor_params = params[:vendor]

			# all of these can be nil if not filled out!
			picture       = card_params[:picture]
			
			relationships = card_params[:relationships] || []
			occasions     = card_params[:occasions] || []
			flavors       = card_params[:flavors] || []
			
			vendor_id     = card_params[:vendor]
			vendor_url    = vendor_params[:vendor_url]
			new_vendor    = vendor_params[:new_vendor]

			@card = Card.create

			unless picture.nil?
				@card.card_images.create(picture: picture)
			end

			relationships.each do |relationship_id|
				@card.card_relationships.create(relationship_id: relationship_id)
			end

			occasions.each do |occasion_id|
				@card.card_occasions.create(occasion_id: occasion_id)
			end

			flavors.each do |flavor_id|
				@card.card_flavors.create(flavor_id: flavor_id)
			end


			if vendor_id || new_vendor

				# new_vendor > vendor from select option
				unless new_vendor.empty?
					vendor = Vendor.create(name: new_vendor)
					vendor_id = vendor.id
				end

				@card.create_card_vendor(vendor_id: vendor_id, url: vendor_url)

			end

			flash[:success] = "Card successfully created"

		end

		def update
			puts "HELLO\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
			puts params.inspect

			if @card = Card.find_by(id: params[:id])
				card_params   = params[:card]

				relationships = card_params[:relationships]
				occasions     = card_params[:occasions]
				flavors       = card_params[:flavors]
				picture				= card_params[:picture]

				# purge each field and refresh with updated data
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
				# only when you have something in that picture input
				unless picture.nil?
					@card.card_images.destroy_all
					@card.card_images.create(picture: picture)
				end

				vendor_id     = card_params[:vendor]
				new_vendor 		= card_params[:new_vendor]
				vendor_url 		= card_params[:vendor_url]

				if vendor_id || new_vendor

					# new_vendor > vendor from select option
					unless new_vendor.empty?
						vendor = Vendor.create(name: new_vendor)
						vendor_id = vendor.id
					end

					# create or update depending on existence of card_vendor (since there can only be 1 vendor in this scenario)
					if @card.card_vendor.nil?
						@card.create_card_vendor(vendor_id: vendor_id)
					else
						@card.card_vendor.update_attribute(:vendor_id, vendor_id)
					end

					@card.card_vendor.update_attribute(:url, vendor_url)

				end

				flash[:success] = "Card updated."
			else
				flash[:danger] = "Failed to update card."
			end
			redirect_to admin_cards_path
		end

		private

			def card_params
				params.require(:card).permit(:picture)
			end

	end
end