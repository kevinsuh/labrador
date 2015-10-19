class CardImage < ActiveRecord::Base
  belongs_to :card
  mount_uploader :picture, AvatarUploader
  validate :picture_size

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image

  enum side: [ :outside, :inside ]

  def crop_image
    if crop_x.present?

      # if Rails.env.production? 
      #   path = self.picture.url
      #   puts path
      # else
      #   path = self.picture.path
      # end

      # mini_magick = MiniMagick::Image.open(path)
      # crop_params = "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
      # mini_magick.crop(crop_params)
      # mini_magick.write(self.picture.path)
      picture.recreate_versions!
    end
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
