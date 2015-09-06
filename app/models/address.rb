class Address < ActiveRecord::Base

  belongs_to :person, polymorphic: true
  has_many :orders, foreign_key: "shipping_address_id"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  

  def set_primary
  	all_addresses = person.addresses.update_all(is_primary: false)
  	update_columns(is_primary: true)
  end

end
