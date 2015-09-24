class Recipient < ActiveRecord::Base

  belongs_to :user
  has_many :addresses, as: :person
  has_many :orders
  validates :user_id, presence: true
  belongs_to :relationship

  # has many occasions through recipient_occasions
  has_many :recipient_occasions, dependent: :destroy
  has_many :occasions, through: :recipient_occasions
  
end
