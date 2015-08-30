class RelationshipsController < ApplicationController
  
  def get_relationships
  	# return all the relationships
  	relationships = Relationship.all
  	respond_to do |format|
  		format.json { render json: relationships }
  	end
  end

end
