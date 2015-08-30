class Card < ActiveRecord::Base
	has_many :orders
	has_many :card_images

	# has many occasion_types through card_occasions
	has_many :card_occasions 
	has_many :occasion_types, through: :card_occasions, source: :occasion

	# has many relationship_types through card_relationships
	
	#has many flavor_types through card_flavors
	
end
