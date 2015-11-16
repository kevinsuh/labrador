class AddUnitedStatesDefaultToCountry < ActiveRecord::Migration
  def change
  	change_column :addresses, :country, :string, :default => "United States"
  end
end
