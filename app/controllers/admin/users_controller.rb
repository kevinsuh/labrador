module Admin

	class UsersController < ApplicationController

		layout "admin_application"

		def index
			@test = "hello world"
		end
	end

end