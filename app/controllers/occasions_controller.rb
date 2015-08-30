class OccasionsController < ApplicationController
  
  def get_occasions
  	# return all the occasions
  	occasions = Occasion.where.not(id: 12) # don't return the "all" option
  	respond_to do |format|
  		format.json { render json: occasions }
  	end
  end

end
