class CreateCardOccasions < ActiveRecord::Migration
  def change
    create_table :card_occasions do |t|
      t.integer :card_id
      t.integer :occasion_id

      t.timestamps null: false
    end
    add_index :card_occasions, :card_id
    add_index :card_occasions, :occasion_id
    add_index :card_occasions, [:card_id, :occasion_id], unique: true # composite index of card + occasion to avoid repeats
  end
end
