class Waitlist < ActiveRecord::Base
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										length: { maximum: 255 }, 
										format: { with: VALID_EMAIL_REGEX }
	before_save :downcase_email

	def downcase_email
		self.email = self.email.downcase
	end
	
end
