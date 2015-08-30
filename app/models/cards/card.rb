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

end
