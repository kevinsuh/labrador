class ProfilePicture < ActiveRecord::Base
	belongs_to :person, polymorphic: true
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private 

	  def card_image_params
	  	params.require(:profile_picture).permit(:picture)
	  end

		def picture_size
			if picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end

end
