class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :is_admin, :is_activated
  include UsersHelper

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if user is valid, and if so return appropriate info
    user = object # user is more intuitive
    data[:is_valid] = user.valid?
    unless user.valid?
      # lets handle only the first error for now
      data[:error_field] = user.errors.messages.first[0]
      error_string = user.errors.messages.first[1][0]

      case error_string
        when "has already been taken"
          error_reason = "email-taken"
        when "is invalid"
        else
          error_reason = "is-invalid"
      end
      data[:error_reason] = error_reason

      # these are all the errors
      data[:errors] = user.errors.messages

      # profile picture if it exists
      profile_picture = user.profile_pictures.first
      if profile_picture && profile_picture.picture?
        data[:profile_picture] = profile_picture.picture.url
      end

    end
    
    data[:gravatar_url] = gravatar_for user
    data[:status] = { logged_in: true }

    # get address for user
    addresses = user.addresses
    data[:addresses] = addresses;

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