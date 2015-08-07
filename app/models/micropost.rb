class Micropost < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }
	mount_uploader :picture, PictureUploader
	default_scope -> { order("created_at DESC") }
	validate :picture_size

	# feed of user and user-following microposts
	class << self
		def feed_for_user(user)
			following_user_ids_subselect = "SELECT relationships.followed_id FROM relationships WHERE relationships.follower_id = :user_id"
			where("user_id IN (#{following_user_ids_subselect}) OR user_id = :user_id", user_id: user.id)
		end
	end

	private
		def picture_size
			if self.picture.size > 5.megabytes
				errors.add(:picture, "should be less than 5MB")
			end
		end

end
