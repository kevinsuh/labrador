class CardsController < ApplicationController

	include CardsHelper
	
	def get_flavors
  	flavor_types = Flavor.all
  	respond_to do |format|
  		format.json { render json: flavor_types }
  	end
  end

  def get_curated_cards
  	
  	card_params = params

  	occasion_id = card_params[:occasion]
  	relationship_id = card_params[:recipientRelationship]
		flavor_ids = card_params[:cardFlavors]

		cards = Card.curated_cards_for occasion_id, relationship_id, flavor_ids
  	
  	respond_to do |format|
  		format.json {render json: cards }
  	end

  end

end
