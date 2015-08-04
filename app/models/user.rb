class User < ActiveRecord::Base

	before_save { self.email.downcase! }

	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										length: { maximum: 255 }, 
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	attr_accessor :remember_token

	has_secure_password # adds virtual attributes :password & :password_confirmation

	# class method to convert pass => digest
	
	class << self
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	# persistent session via cookies
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(self.remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	# to mimic has_secure_password.authenticate for our custom tokens
	def authenticated?(token, digest)
		BCrypt::Password.new(digest).is_password?(token)
	end

end
