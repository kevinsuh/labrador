class CreateWaitlists < ActiveRecord::Migration
  def change
    create_table :waitlists do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
