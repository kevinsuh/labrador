class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :suite
      t.string :city
      t.string :state
      t.integer :zipcode
      t.boolean :is_primary, default: false

      t.timestamps null: false
    end
    add_foreign_key :addresses, :users
  end
end
