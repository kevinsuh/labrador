class RelationshipsController < ApplicationController
  	
  # this just returns relationship types
  def get_relationships
  	# return all the relationships besides "all"
  	relationships = Relationship.where.not(id: 12)
  	respond_to do |format|
  		format.json { render json: relationships }
  	end
  end

end
