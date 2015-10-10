class CardsController < ApplicationController

	include CardsHelper
  before_action :require_login, only: [:queue_wizard]
	
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

  def get_cards_for_occasion
    occasion_id = params[:occasion_id]
    cards = Card.for_occasion occasion_id

    respond_to do |format|
      format.json { render json: cards }
    end
  end

  # initialize card queue wizard
  def queue_wizard

    card_params = params
    render layout: "wizard_application"

    puts params.inspect
    
  end

end
