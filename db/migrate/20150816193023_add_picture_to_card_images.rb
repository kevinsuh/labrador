class AddPictureToCardImages < ActiveRecord::Migration
  def change
    add_column :card_images, :picture, :string
  end
end
