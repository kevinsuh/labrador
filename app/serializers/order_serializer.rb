class OrderSerializer < ActiveModel::Serializer
  attributes :id

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if user is valid, and if so return appropriate info
    data[:is_valid] = object.valid?
    unless object.valid?
      # lets handle only the first error for now
      data[:error_field] = object.errors.messages.first[0]
      data[:error_string] = object.errors.messages.first[1][0]

      # these are all the errors
      data[:errors] = object.errors.messages
    end
  	data
  end


end
