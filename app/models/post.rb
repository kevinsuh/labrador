class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :user
	validates :user_id, presence: true

	# have our json responses include associated comments
	def as_json(options = {})
		post = super
		post[:comments] = json_include_comments
		post
	end

	private

		# this includes comments with additional info attached
		# for now this is just user's name
		def json_include_comments
			post_comments = comments.joins(:user).where("users.id = comments.user_id").select("comments.*, users.name").as_json
		end

end
