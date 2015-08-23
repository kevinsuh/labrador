class RelationshipsController < ApplicationController
  
  def get_relationship_types
  	# return all the relationships
  	relationship_types = RelationshipType.all
  	respond_to do |format|
  		format.json { render json: relationship_types }
  	end
  end

end
