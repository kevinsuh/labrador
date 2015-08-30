class RenameRelationshipTypesToRelationships < ActiveRecord::Migration
  def change
  	rename_table :relationship_types, :relationships
  	rename_column :relationships, :relationship_name, :name
  end
end
