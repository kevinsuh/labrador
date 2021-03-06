module UsersHelper

	def gravatar_for(user, options = {size: 60})

		email = user.email.downcase
		size = options[:size]
		gravatar_id = Digest::MD5::hexdigest(email)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		gravatar_url
	end
	
end
