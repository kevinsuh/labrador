class Recipient < ActiveRecord::Base
  belongs_to :user
  has_many :addresses, as: :person
  validates :user_id, presence: true
  
end
