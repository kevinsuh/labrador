class CreateProfilePicturesTable < ActiveRecord::Migration
  def change
    create_table :profile_pictures_tables do |t|
      t.references :person, polymorphic: true, index: true
      t.string :picture
    end
  end
end
