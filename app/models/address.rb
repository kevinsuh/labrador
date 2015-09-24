class Address < ActiveRecord::Base

  belongs_to :person, polymorphic: true
  has_many :orders, foreign_key: "shipping_address_id"

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true

  default_scope { where(is_visible: true) }

  def set_primary
  	all_addresses = person.addresses.update_all(is_primary: false)
  	update_columns(is_primary: true)
  end

end
