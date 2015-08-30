class Flavor < ActiveRecord::Base
	has_many :card_flavors
	has_many :cards, through: :card_flavors
end
