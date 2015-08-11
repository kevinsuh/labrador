class Comment < ActiveRecord::Base

	include FlapperNewsHelper

  belongs_to :post
  belongs_to :user
  has_many :comment_upvotes
  validates :user_id, presence: true

  # have our json responses include associated comments
	def as_json(options = {})
		
		post = super

		# attach user info to each comment
		post[:user] = user_info
		
		post

	end
  
end
