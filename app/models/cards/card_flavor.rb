class CardFlavor < ActiveRecord::Base
	belongs_to :card
	belongs_to :flavor
	validates :card_id, presence: true
	validates :flavor_id, presence: true
end
