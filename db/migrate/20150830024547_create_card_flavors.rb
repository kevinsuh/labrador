class CreateCardFlavors < ActiveRecord::Migration
  def change
    create_table :card_flavors do |t|
      t.integer :card_id
      t.integer :flavor_id

      t.timestamps null: false
    end
    add_index :card_flavors, :card_id
    add_index :card_flavors, :flavor_id
    add_index :card_flavors, [:card_id, :flavor_id], unique: true
  end
end
