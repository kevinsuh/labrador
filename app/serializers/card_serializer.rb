class CardSerializer < ActiveModel::Serializer
  attributes :id

  # return with the associated card_images
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

    card_images = CardImage.where(card_id: data[:id])
    
    card_image_urls = card_images.map { 
    	|image| image.picture.url if image.picture? 
  		}.compact

  	data[:card_images] = card_image_urls

  	data
  end

end
