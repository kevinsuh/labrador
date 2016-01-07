class AddressSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :street, :suite, :city, :city, :state, :zipcode, :created_at, :person_id, :person_type
  has_one :person

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if address is valid, and if so return appropriate info
    data[:is_valid] = object.valid?
    unless object.valid?
      # lets handle only the first error for now
      data[:error_field] = object.errors.messages.first[0]
      error_string = object.errors.messages.first[1][0]
      
      case error_string
        when "has already been taken"
          error_reason = "email-taken"
        when "is invalid"
        else
          error_reason = "is-invalid"
      end
      data[:error_reason] = error_reason

      # these are all the errors
      data[:errors] = object.errors.messages
    end
  	data
  end
end
