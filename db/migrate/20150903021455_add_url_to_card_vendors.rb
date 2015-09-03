class AddUrlToCardVendors < ActiveRecord::Migration
  def change
    add_column :card_vendors, :url, :string
  end
end
