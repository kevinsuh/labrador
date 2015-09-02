class Card < ActiveRecord::Base
	has_many :orders
	has_many :card_images

	# has many occasions through card_occasions
	has_many :card_occasions 
	has_many :occasions, through: :card_occasions

	# has many relationships through card_relationships
	has_many :card_relationships
	has_many :relationships, through: :card_relationships

	#has many flavors through card_flavors
	has_many :card_flavors
	has_many :flavors, through: :card_flavors

	class << self
		# return the curated cards for the 3 current filters
		# ex. occasion = christmas
		# ex. relationship = mother
		# ex. flavor = quirky
		def curated_cards_for(occasion_id, relationship_id, flavor_ids)

			# include cards that are appropriate for all relationships and occasions
			all_relationships_id = 12
			all_occasions_id     = 12

			# if flavor_ids is empty, then it means all
			if flavor_ids.nil?
				flavor_ids = Flavor.ids
			end

			# find the cards that are filtered by relationship_id, occasion_id, and contains at least one of the flavor_ids
			curated_cards = Card.joins("
				LEFT JOIN card_relationships
					ON card_relationships.card_id = cards.id
				LEFT JOIN card_occasions
					ON card_occasions.card_id = cards.id
				LEFT JOIN card_flavors
					ON card_flavors.card_id = cards.id").where("
				card_relationships.relationship_id IN (:relationship_ids)
				AND card_occasions.occasion_id IN (:occasion_ids)
				AND card_flavors.flavor_id IN (:flavor_ids)", relationship_ids: [all_relationships_id, relationship_id], occasion_ids: [all_occasions_id, occasion_id], flavor_ids: flavor_ids).distinct

			curated_cards
		end

		# get the cards associated with specific filters
		# this is initially for admin use
		def all_filtered(filters = {})

			cards = Card.joins("
				LEFT JOIN card_relationships
					ON card_relationships.card_id = cards.id
				LEFT JOIN card_occasions
					ON card_occasions.card_id = cards.id
				LEFT JOIN card_flavors
					ON card_flavors.card_id = cards.id")
			cards

		end

	end
end
