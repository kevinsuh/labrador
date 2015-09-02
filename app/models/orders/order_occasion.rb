class OrderOccasion < ActiveRecord::Base
	belongs_to :order
	belongs_to :occasion
	
	validates :order_id, presence: true
	validates :occasion_id, presence: true

end