class CardImage < ActiveRecord::Base
  belongs_to :card
  mount_uploader :picture, AvatarUploader
  validate :picture_size

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_picture

  def crop_picture
  	picture.recreate_versions! if crop_x.present?
  end

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
