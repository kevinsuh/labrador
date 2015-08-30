class CreateCardRelationships < ActiveRecord::Migration
  def change
    create_table :card_relationships do |t|
      t.integer :card_id
      t.integer :relationship_id

      t.timestamps null: false
    end
    add_index :card_relationships, :card_id
    add_index :card_relationships, :relationship_id
    add_index :card_relationships, [:card_id, :relationship_id], unique: true
  end
end
