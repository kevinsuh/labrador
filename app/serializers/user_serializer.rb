class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :is_admin, :is_activated, :birth_month, :birth_day, :birth_year, :phone_number, :username
  include UsersHelper

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
    
    # check if user is valid, and if so return appropriate info
    user = object # user is more intuitive
    data[:is_valid] = user.valid?
    data[:status] = { logged_in: true }
    if user.valid?

      data[:gravatar_url] = gravatar_for user

      # get addresses for user
      addresses = user.addresses

      if addresses.length > 0

        data[:addresses] = addresses;
        # get the primary address
        primary_address = addresses.where(is_primary: true).last
        unless primary_address
          addresses.first.set_primary
          primary_address = addresses.where(is_primary: true).last
        end

        data[:primary_address] = primary_address
      end

      

      # get stripe account
      # user needs customer_id in order to retrieve card info
      if stripe_account = user.stripe_account

        customer_id      = stripe_account.customer_id
        customer         = Stripe::Customer.retrieve(customer_id)
        data[:stripe_customer] = customer

        # get the default card for user
        cards = customer.sources.data
        default_source = customer.default_source
        cards.each do |card|
          if card.id == default_source
            data[:primary_card] = card
            break
          end
        end
      end
    else
      puts user.inspect
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