class AddStatusToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :status, :integer, default: 0
  end
end
