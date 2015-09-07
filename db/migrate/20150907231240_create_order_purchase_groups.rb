class CreateOrderPurchaseGroups < ActiveRecord::Migration
  def change
    create_table :order_purchase_groups do |t|
      t.references :order, index: true

      t.timestamps null: false
    end
    add_foreign_key :order_purchase_groups, :orders
  end
end
