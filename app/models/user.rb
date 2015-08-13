class User < ActiveRecord::Base

	before_save :downcase_email
	before_create :create_activation_digest

	validates :name, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
										length: { maximum: 255 }, 
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, allow_blank: true
	attr_accessor :remember_token, :activation_token, :password_reset_token

	has_secure_password # adds virtual attributes :password & :password_confirmation

	# flapper_news demo
	has_many :posts
	has_many :comments
	has_many :post_upvotes
	has_many :comment_upvotes

	# cardagain-specific
	has_many :addresses

	# User class methods
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

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	# reset password
	def reset_password
		self.password_reset_token = User.new_token
		update_columns(password_reset_digest: User.digest(self.password_reset_token), password_reset_sent_at: Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def reset_in_time?
		self.password_reset_sent_at > 2.hours.ago
	end

	# activate the user!
	def activate
		update_columns(is_activated: true, activated_at: Time.zone.now)
	end

	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(self.activation_token)
	end

	def downcase_email
		self.email = self.email.downcase
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	# to mimic has_secure_password.authenticate for our custom tokens
	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest") # ex) self.activation_digest
		BCrypt::Password.new(digest).is_password?(token)
	end

end
