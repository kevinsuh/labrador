class CardOccasion < ActiveRecord::Base
	belongs_to :card
	belongs_to :occasion
	
	validates :card_id, presence: true
	validates :occasion_id, presence: true
end
