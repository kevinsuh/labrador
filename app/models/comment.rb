class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :comment_upvotes
  validates :user_id, presence: true
  
end
