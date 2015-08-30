class CardImage < ActiveRecord::Base
  belongs_to :card
  mount_uploader :picture, PictureUploader

  private 

  def card_image_params
  	params.require(:card_image).permit(:picture)
  end
end
