class RenameCardFlavorTypesToFlavor < ActiveRecord::Migration
  def change
  	rename_table :card_flavor_types, :flavors
  end
end
