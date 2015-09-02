class Recipient < ActiveRecord::Base

  belongs_to :user
  has_many :addresses, as: :person
  has_many :orders
  validates :user_id, presence: true

  default_scope -> { select("recipients.*").select("relationships.name").joins("LEFT JOIN relationships ON recipients.relationship = relationships.id")}
  
end
