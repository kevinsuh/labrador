module Admin

	class CardImagesController < ApplicationController

		layout "admin_application"
		
		before_action :require_login
  	before_action :admin_user

  	def index
  		@card = Card.find(params[:card_id])
  		@card_images = @card.card_images

  		@new_card_image = CardImage.new
  	end

  	def create
  		@card = Card.find(params[:card_id])

  		card_image_params = params[:card_image]
  		picture       		= card_image_params[:picture]

  		if picture.nil?
  			flash[:danger] = "Could not add picture"
  			redirect_to admin_card_card_images_path(@card)
  		else
  			@card_image = @card.card_images.create(picture: picture)
  			flash[:success] = "Please crop now"
  			redirect_to admin_card_card_images_path(@card) # should be crop
  		end
  		
  	end

		def edit
			
		end

		def update
			puts params.inspect
		end

	end
end