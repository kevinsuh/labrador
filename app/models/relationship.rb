class Relationship < ActiveRecord::Base
	has_many :card_relationships
	has_many :cards, through: :card_relationships
end
