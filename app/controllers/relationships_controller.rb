class RelationshipsController < ApplicationController
  	
  # this just returns relationship types
  def get_relationships
  	# return all the relationships besides "all"
  	relationships = Relationship.where.not(id: 12)
  	respond_to do |format|
  		format.json { render json: relationships }
  	end
  end

  # get all of current_user's recipients
  def get_current_recipients
  	recipients = current_user.recipients
  	respond_to do |format|
  		format.json { render json: recipients }
  	end
  end

end
