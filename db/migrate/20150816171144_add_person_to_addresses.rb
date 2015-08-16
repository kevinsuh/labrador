class AddPersonToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :person, polymorphic: true, index: true
    remove_column :addresses, :user_id 
  end
end
