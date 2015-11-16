class AddStatusToRecipientOccasions < ActiveRecord::Migration
  def change
    add_column :recipient_occasions, :status, :integer, default: 0
  end
end
