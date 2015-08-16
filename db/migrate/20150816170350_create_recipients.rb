class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
    add_foreign_key :recipients, :users
  end
end
