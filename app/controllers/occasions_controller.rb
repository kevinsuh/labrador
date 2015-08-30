class OccasionsController < ApplicationController
  
  def get_occasions
  	# return all the occasions
  	occasions = Occasion.all
  	respond_to do |format|
  		format.json { render json: occasions }
  	end
  end

end
