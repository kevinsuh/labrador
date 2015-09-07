class Card < ActiveRecord::Base
	has_many :orders
	has_many :card_images, dependent: :destroy

	# has many occasions through card_occasions
	has_many :card_occasions, dependent: :destroy 
	has_many :occasions, through: :card_occasions

	# has many relationships through card_relationships
	has_many :card_relationships, dependent: :destroy
	has_many :relationships, through: :card_relationships

	#has many flavors through card_flavors
	has_many :card_flavors, dependent: :destroy
	has_many :flavors, through: :card_flavors

	# has one vendor through card_vendors
	has_one :card_vendor, dependent: :destroy
	has_one :vendor, through: :card_vendor

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
				AND card_flavors.flavor_id IN (:flavor_ids)", relationship_ids: [all_relationships_id, relationship_id], occasion_ids: [all_occasions_id, occasion_id], flavor_ids: flavor_ids).distinct.limit(4)

			curated_cards
		end

		# get the cards associated with specific filters
		# this is initially for admin use
		def all_with_filters(filters = {})

			cards = Card.joins("
				LEFT JOIN card_relationships
					ON card_relationships.card_id = cards.id
				LEFT JOIN card_occasions
					ON card_occasions.card_id = cards.id
				LEFT JOIN card_flavors
					ON card_flavors.card_id = cards.id
				LEFT JOIN card_vendors
					ON card_vendors.card_id = cards.id")

			where_statement = String.new

			filterCount = 1
			filters.each do |index, filter|
				puts "index: #{index} and filter: #{filter}"
				if filter.nil? || filter.empty?
					next
				end
				case index
				when :occasions
					where_string = filterCount == 1 ? "card_occasions.occasion_id IN (:occasion_ids)" : " AND card_occasions.occasion_id IN (:occasion_ids)"
					where_statement << ActiveRecord::Base.send(:sanitize_sql_array, [where_string, occasion_ids: filter])
					filterCount+=1
				when :relationships
					where_string = filterCount == 1 ? "card_relationships.relationship_id IN (:relationship_ids)" : " AND card_relationships.relationship_id IN (:relationship_ids)"
					where_statement << ActiveRecord::Base.send(:sanitize_sql_array, [where_string, relationship_ids: filter])
					filterCount+=1
				when :flavors
					where_string = filterCount == 1 ? "card_flavors.flavor_id IN (:flavor_ids)" : " AND card_flavors.flavor_id IN (:flavor_ids)"					
					where_statement << ActiveRecord::Base.send(:sanitize_sql_array, [where_string, flavor_ids: filter])
					filterCount+=1
				when :vendors
					where_string = filterCount == 1 ? "card_vendors.vendor_id IN (:vendor_ids)" : " AND card_vendors.vendor_id IN (:vendor_ids)"					
					where_statement << ActiveRecord::Base.send(:sanitize_sql_array, [where_string, vendor_ids: filter])
					filterCount+=1
				else
					puts "this is the case: #{index}"
				end
			end

			filtered_cards = cards.where(where_statement)
			filtered_cards.distinct

			filtered_cards

		end

	end
end
