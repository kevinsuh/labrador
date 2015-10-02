class RenameProfilePicturesTable < ActiveRecord::Migration
  def change
  	rename_table :profile_pictures_tables, :profile_pictures
  	change_table :profile_pictures do |t|
  		t.timestamps
  	end
  end
end
