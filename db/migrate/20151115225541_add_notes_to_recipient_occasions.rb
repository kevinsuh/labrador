class AddNotesToRecipientOccasions < ActiveRecord::Migration
  def change
    add_column :recipient_occasions, :notes, :text
  end
end
