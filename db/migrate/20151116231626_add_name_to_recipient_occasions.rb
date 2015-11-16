class AddNameToRecipientOccasions < ActiveRecord::Migration
  def change
    add_column :recipient_occasions, :name, :string
  end
end
