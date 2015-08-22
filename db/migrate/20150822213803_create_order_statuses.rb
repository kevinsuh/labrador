class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.references :order, index: true
      t.boolean :purchased, default: false
      t.boolean :delivered, default: false
      t.boolean :canceled, default: false
      t.boolean :refunded, default: false

      t.timestamps null: false
    end
    add_foreign_key :order_statuses, :orders
  end
end
