class RecipientOccasionSerializer < ActiveModel::Serializer
  attributes :id, :recipient_id, :occasion_id, :day, :month, :notes

  # attribute method is hash of JSON attributes
  def attributes
  	data = super # get the current JSON object
  	recipient_occasion = object

    data[:is_visible] = 1 # visible by default

    recipient_id = data[:recipient_id]
    recipient = Recipient.find_by(id: recipient_id)
    data[:recipient] = recipient

    occasion_id = data[:occasion_id]
    occasion = Occasion.find_by(id: occasion_id)
    data[:occasion] = occasion

    data

  end

end
