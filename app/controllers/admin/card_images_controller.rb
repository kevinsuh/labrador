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
			picture           = card_image_params[:picture]
			side              = card_image_params[:side].to_i

  		if picture.nil?
  			flash[:danger] = "Could not add picture"
  			redirect_to admin_card_card_images_path(@card)
  		else
  			@card_image = @card.card_images.create(picture: picture, side: side)
  			flash[:success] = "Please crop now"
  			render :crop
  		end

  	end

		def edit
			
		end

		def destroy
			@card = Card.find(params[:card_id])
			@card_image = CardImage.find(params[:id]).destroy
			flash[:success] = "Card Image deleted"
			redirect_to admin_card_card_images_path(@card)
		end

		# this is for updating on the card_images admin index
		def update_image

			@card             = Card.find(params[:card_id])
			@card_image       = CardImage.find(params[:id])
			
			card_image_params = params[:card_image]
			side              = card_image_params[:side].to_i

			@card_image.update_column(:side, side)
			if @card_image.picture.nil?
				flash[:danger] = "Could not find picture"
  			redirect_to admin_card_card_images_path(@card)
  		else
  			flash[:success] = "Please crop now"
  			render :crop
  		end

		end

		# this is the actual cropping of the image
		def update
			@card = Card.find(params[:card_id])
			@card_image = CardImage.find(params[:id])
			if @card_image.update_attributes(card_image_params)
				flash[:success] = "Successfully cropped image"
			else
				flash[:danger] = "Failed to crop image"
			end
			redirect_to admin_card_card_images_path(@card)
		end

		private

			def card_image_params
				params.require(:card_image).permit(:crop_x, :crop_y, :crop_w, :crop_h)
			end
	end
end