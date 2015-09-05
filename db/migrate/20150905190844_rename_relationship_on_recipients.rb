class RenameRelationshipOnRecipients < ActiveRecord::Migration
  def change
  	rename_column :recipients, :relationship, :relationship_id
  end
end
