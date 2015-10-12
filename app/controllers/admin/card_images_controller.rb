module Admin

	class CardImagesController < ApplicationController

		layout "admin_application"
		
		before_action :require_login
  	before_action :admin_user

		def edit
			@card_image = CardImage.find(params[:id])
		end

		def update
			puts params.inspect
		end

	end
end