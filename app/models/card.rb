class Card < ActiveRecord::Base
	has_many :orders
	has_many :card_images
end
