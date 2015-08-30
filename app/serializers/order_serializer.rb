class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :recipient_id, :card_id, :recipient_arrival_date, :created_at

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

    # attach card information if the order is a card
    card_id = data[:card_id]
    card = Card.find_by(id: card_id)
    data[:card] = card

    card_images = CardImage.where(card_id: card_id)
    card_image_urls = card_images.map { 
        |image| image.picture.url if image.picture? 
        }.compact
    data[:card_images] = card_image_urls

    # attach recipient information
    recipient_id = data[:recipient_id]
    recipient = Recipient.find_by(id: recipient_id)
    data[:recipient] = recipient

    data

  end


end
