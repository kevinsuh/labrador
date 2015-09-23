class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :first_name, :last_name, :created_at, :updated_at, :relationship_id

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
  	recipient = object

    relationship_id = data[:relationship_id]
    relationship = Relationship.find_by(id: relationship_id)
    data[:relationship] = relationship

    primary_address = recipient.addresses.first
    data[:primary_address] = primary_address

    data

  end

end
