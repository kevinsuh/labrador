class Address < ActiveRecord::Base
  belongs_to :person, polymorphic: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  # potentially have other email address validators?
  # internet says that you need to ultimately trust the consumer though

end
