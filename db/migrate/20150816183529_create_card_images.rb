class CreateCardImages < ActiveRecord::Migration
  def change
    create_table :card_images do |t|
      t.references :card, index: true

      t.timestamps null: false
    end
    add_foreign_key :card_images, :cards
  end
end
