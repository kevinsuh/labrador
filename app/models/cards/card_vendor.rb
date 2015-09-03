class CardVendor < ActiveRecord::Base
  belongs_to :card
  belongs_to :vendor

  validates :card_id, presence: true
	validates :vendor_id, presence: true
end
