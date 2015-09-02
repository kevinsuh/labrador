class CreateTableOrdersOccasions < ActiveRecord::Migration
  def change
    create_table :order_occasions do |t|
      t.integer :order_id
      t.integer :occasion_id

      t.timestamps null: false
    end
    add_index :order_occasions, :order_id
    add_index :order_occasions, :occasion_id
  end
end
