class CreateCardVendors < ActiveRecord::Migration
  def change
    create_table :card_vendors do |t|
      t.references :card, index: true
      t.references :vendor, index: true

      t.timestamps null: false
    end
    add_foreign_key :card_vendors, :cards
    add_foreign_key :card_vendors, :vendors
  end
end
