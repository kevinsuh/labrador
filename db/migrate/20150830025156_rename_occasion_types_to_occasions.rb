class RenameOccasionTypesToOccasions < ActiveRecord::Migration
  def change
  	rename_table :occasion_types, :occasions
  	rename_column :occasions, :occasion_name, :name
  end
end
