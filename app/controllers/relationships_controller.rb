class RelationshipsController < ApplicationController
	# you should have to be logged in
	before_action :require_login, only: [:create, :destroy]

	# follow
  def create
  	followed_id = params[:followed_id]
  	@user = User.find_by(id: followed_id)
  	current_user.follow(@user) # creates the relationship record
  	respond_to do |format|
  		format.html { redirect_to @user }
  		format.js
  	end
  end

  # unfollow
  def destroy
  	@user = Relationship.find(params[:id]).followed
  	current_user.unfollow(@user) # destroys the existing relationship record
  	respond_to do |format|
  		format.html { redirect_to @user }
  		format.js
  	end
  end
end
