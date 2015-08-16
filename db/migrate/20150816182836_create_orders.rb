class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :recipient, index: true
      t.references :card, index: true
      t.datetime :send_date
      t.datetime :expected_arrival_date

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
    add_foreign_key :orders, :recipients
    add_foreign_key :orders, :cards
  end
end
