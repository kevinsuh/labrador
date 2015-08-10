class Post < ActiveRecord::Base
	has_many :comments

	# have our json responses include associated comments
	def as_json(options = {})
		super(options.merge(include: :comments))
	end
end
