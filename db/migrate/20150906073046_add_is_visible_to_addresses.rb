class AddIsVisibleToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :is_visible, :boolean, default: true
  end
end
