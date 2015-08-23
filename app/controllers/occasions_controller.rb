class OccasionsController < ApplicationController
  
  def get_occasion_types
  	# return all the occasions
  	occasion_types = OccasionType.all
  	respond_to do |format|
  		format.json { render json: occasion_types }
  	end
  end

end
