class RelationshipsController < ApplicationController
  
  def get_relationships
  	# return all the relationships
  	relationships = Relationship.where.not(id: 12) # don't return "all" option
  	respond_to do |format|
  		format.json { render json: relationships }
  	end
  end

end
