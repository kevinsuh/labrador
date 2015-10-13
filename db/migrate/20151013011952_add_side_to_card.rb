class AddSideToCard < ActiveRecord::Migration
  def change
  	add_column :card_images, :side, :integer
  end
end
