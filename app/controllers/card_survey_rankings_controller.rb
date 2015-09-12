class CardSurveyRankingsController < ApplicationController

	# display the cards for that given occasion-relationship-flavor combination
	include CardSurveyRankingsHelper

	def index

		# if nothing for that user exists, then take the minimum value (1)
		max_occasion_id     = Occasion.maximum(:id)
		max_relationship_id = Relationship.maximum(:id)
		max_flavor_id       = Flavor.maximum(:id)

		@occasions = Occasion.all
		@relationships = Relationship.all
		@flavors = Flavor.all

		final_occasion_id     = 1
		final_relationship_id = 1
		final_flavor_id       = 1

		filter_params    = params[:survey_filter] 

		if filter_params # this means user intentionally put search parameters
			@occasion_id     = filter_params[:occasions]
			@relationship_id = filter_params[:relationships]
			@flavor_id       = filter_params[:flavors]
		else
			unless current_user.card_survey_rankings.empty?
				
				(1 .. max_occasion_id).each do |occasion_id|
					
					final_occasion_id = occasion_id

					unique_relationship_ids = current_user.card_survey_rankings.select(:id, :relationship_id).where("occasion_id = :occasion_id", occasion_id: occasion_id).distinct.map(&:relationship_id)

					if unique_relationship_ids.count == max_relationship_id

						(1 .. max_relationship_id).each do |relationship_id|
							
							final_relationship_id = relationship_id

							unique_flavor_ids = current_user.card_survey_rankings.select(:id, :flavor_id).where("occasion_id = :occasion_id AND relationship_id = :relationship_id", occasion_id: occasion_id, relationship_id: relationship_id).distinct.map(&:flavor_id)

							if unique_flavor_ids.count == max_flavor_id
								next # at this point, try the next relationship_id
							else
								# at this point, find the unique flavor_id
								final_flavor_id = find_missing_minimum(unique_flavor_ids, max_flavor_id)
								break
							end
						end
					else
						final_relationship_id = find_missing_minimum(unique_relationship_ids, max_relationship_id)
						break
					end
				end
			end
			@occasion_id       = final_occasion_id
			@relationship_id   = final_relationship_id
			@flavor_id         = final_flavor_id
		end

		
		@already_completed = current_user.card_survey_rankings.where(occasion_id: @occasion_id, relationship_id: @relationship_id, flavor_id: @flavor_id).count > 0 ? true : false

		# if already completed, then filter to what the user chose
		if @already_completed
			user_ranking = current_user.card_survey_rankings.where(occasion_id: @occasion_id, relationship_id: @relationship_id, flavor_id: @flavor_id).first
			@cards = Array.new
			@cards << Card.find(user_ranking.first_card_id) if user_ranking.first_card_id
			@cards << Card.find(user_ranking.second_card_id) if user_ranking.second_card_id
			@cards << Card.find(user_ranking.third_card_id) if user_ranking.third_card_id
			@cards << Card.find(user_ranking.fourth_card_id) if user_ranking.fourth_card_id
			@cards << Card.find(user_ranking.fifth_card_id) if user_ranking.fifth_card_id
			@cards << Card.find(user_ranking.sixth_card_id) if user_ranking.sixth_card_id
			@cards << Card.find(user_ranking.seventh_card_id) if user_ranking.seventh_card_id
			@cards << Card.find(user_ranking.eighth_card_id) if user_ranking.eighth_card_id
			@initial_rankings = @cards.map{ |card| card.id }.join(",")
		else
			# get the cards that are filtered based on this
			filters = Hash.new
			filters[:occasions] = [@occasion_id]
			filters[:relationships] = [@relationship_id]
			filters[:flavors] = [@flavor_id]
			@cards = Card.all_with_filters filters
			@cards.limit(8)
			@initial_rankings = @cards.map{ |card| card.id }.join(",")	
		end

	end

	# submit survey
	def submit_survey
		
		image_order_string = params[:image_order]
		occasion_id        = params[:occasion_id]
		relationship_id    = params[:relationship_id]
		flavor_id          = params[:flavor_id]
		
		image_order_array  = image_order_string.split(',')

		already_completed = current_user.card_survey_rankings.where(occasion_id: occasion_id, relationship_id: relationship_id, flavor_id: flavor_id).count > 0 ? true : false

		survey_ranking = already_completed ? current_user.card_survey_rankings.where(occasion_id: occasion_id, relationship_id: relationship_id, flavor_id: flavor_id).first : current_user.card_survey_rankings.build(occasion_id: occasion_id, relationship_id: relationship_id, flavor_id: flavor_id)

		image_order_array.each_with_index do |val, index|
			case index
			when 0
				survey_ranking.first_card_id   = val
			when 1
				survey_ranking.second_card_id  = val
			when 2
				survey_ranking.third_card_id   = val
			when 3
				survey_ranking.fourth_card_id  = val
			when 4
				survey_ranking.fifth_card_id   = val
			when 5
				survey_ranking.sixth_card_id   = val
			when 6
				survey_ranking.seventh_card_id = val
			when 7
				survey_ranking.eigth_card_id   = val
			end
		end

		survey_ranking.save

		redirect_to card_survey_rankings_path
	end

end
