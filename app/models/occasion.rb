class Occasion < ActiveRecord::Base

	# occasions have many cards through card_occasions
	has_many :card_occasions
	has_many :cards, through: :card_occasions

	has_many :order_occasions

end
