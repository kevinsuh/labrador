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

		filter_params = params[:survey_filter]

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
		@already_completed = current_user.card_survey_rankings.where(occasion_id: @occasion_id, relationship_id: @relationship_id, flavor_id: @flavor_id).count > 0 ? true : false

		# get the cards that are filtered based on this
		filters = Hash.new
		filters[:occasions] = [@occasion_id]
		filters[:relationships] = [@relationship_id]
		filters[:flavors] = [@flavor_id]
		@cards = Card.all_with_filters filters
		@initial_rankings = @cards.map{ |card| card.id }.join(",")

	end

end
