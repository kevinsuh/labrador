# the relationships that a card supports
# i.e. bday card for mom vs bday card for dad
class CardRelationship < ActiveRecord::Base
	belongs_to :card
	belongs_to :relationship
	
	validates :card_id, presence: true
	validates :relationship_id, presence: true
end
