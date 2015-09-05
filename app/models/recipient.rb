class Recipient < ActiveRecord::Base

  belongs_to :user
  has_many :addresses, as: :person
  has_many :orders
  validates :user_id, presence: true
  belongs_to :relationship
  
end
