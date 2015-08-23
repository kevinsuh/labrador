class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient
  belongs_to :card
  has_one :order_status
end
