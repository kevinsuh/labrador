class CardOccasion < ActiveRecord::Base
	belongs_to :card
	belongs_to :occasion, class_name: "OccasionType"
	validates :card_id, presence: true
	validates :ocassion_id, presence: true
end
