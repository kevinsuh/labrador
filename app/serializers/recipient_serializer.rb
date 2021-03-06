class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :created_at, :updated_at, :relationship_id

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
  	recipient = object

    data[:is_visible] = 1 # visible by default

    relationship_id = data[:relationship_id]
    relationship = Relationship.find_by(id: relationship_id)
    data[:relationship] = relationship

    primary_address = recipient.addresses.first
    data[:primary_address] = primary_address

    addresses = recipient.addresses
    data[:addresses] = addresses

    occasions = Array.new

    recipient_occasions = recipient.recipient_occasions.live
    recipient_occasions.each do |recipient_occasion|

      occasion_data                      = Hash.new
      occasion_data[:recipient_occasion] = recipient_occasion
      occasion                           = recipient_occasion.occasion
      occasion_data[:occasion]           = occasion
      occasions << occasion_data

    end

    data[:occasions] = occasions

    # profile picture if it exists
    profile_picture = recipient.profile_pictures.first
    if profile_picture && profile_picture.picture?
      data[:profile_picture] = profile_picture.picture.url
    end

    data

  end

end
