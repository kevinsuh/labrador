class CardImage < ActiveRecord::Base
  belongs_to :card
  mount_uploader :picture, PictureUploader
end
