class CreateRecipientOccasions < ActiveRecord::Migration
  def change
    create_table :recipient_occasions do |t|
      t.references :recipient, index: true
      t.references :occasion, index: true
      t.datetime :occasion_date

      t.timestamps null: false
    end
    add_foreign_key :recipient_occasions, :recipients
    add_foreign_key :recipient_occasions, :occasions
  end
end
