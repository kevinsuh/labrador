class CardOccasion < ActiveRecord::Base
	belongs_to :card
	belongs_to :occasion, class_name: "OccasionType"
end
