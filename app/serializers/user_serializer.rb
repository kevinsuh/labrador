class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if user is valid, and if so return appropriate info
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

# superfluous info you may need one day
# data[:scope] = scope # scope is CURRENT USER

# the return value of this gets added as key: value!
# key = method name, value = return value
# def object_call
#   object #object is the user model
# end