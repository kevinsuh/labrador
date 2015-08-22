class RemoveSendDateFromOrdersRenameExpectedArrivalDate < ActiveRecord::Migration
  def change
  	remove_column :orders, :send_date
  	rename_column :orders, :expected_arrival_date, :recipient_arrival_date
  	add_column :orders, :pre_address, :boolean, default: false
  end
end
