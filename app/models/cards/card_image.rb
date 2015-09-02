class CardImage < ActiveRecord::Base
  belongs_to :card
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private 

	  def card_image_params
	  	params.require(:card_image).permit(:picture)
	  end

		def picture_size
			if picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end  
end
