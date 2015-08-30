class OccasionType < ActiveRecord::Base

	# occasions have many cards through card_occasions
	has_many :card_occasions, class_name: "CardOccasion",
														foreign_key: "occasion_id"
	has_many :cards, through: :card_occasions

end
