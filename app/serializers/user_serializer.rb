class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if user is valid, and if so return appropriate info
    data[:is_valid] = object.valid?
    unless object.valid?
      data[:errors] = object.errors.full_messages
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