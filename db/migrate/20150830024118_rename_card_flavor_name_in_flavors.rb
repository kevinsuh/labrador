class RenameCardFlavorNameInFlavors < ActiveRecord::Migration
  def change
  	rename_column :flavors, :card_flavor_name, :name
  end
end
