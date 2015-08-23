class OccasionsController < ApplicationController
  
  def get_occasion_types
  	# return all the occasions
  	occasions = OccasionType.all
  	respond_to do |format|
  		format.json { render json: occasions }
  	end
  end
  
end
