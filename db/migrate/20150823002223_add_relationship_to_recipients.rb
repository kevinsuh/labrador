class AddRelationshipToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :relationship, :Integer
  end
end
