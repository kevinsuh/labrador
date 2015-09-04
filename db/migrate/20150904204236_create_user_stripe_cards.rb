class CreateUserStripeCards < ActiveRecord::Migration
  def change
    create_table :user_stripe_cards do |t|
      t.references :user, index: true
      t.string :customer_id

      t.timestamps null: false
    end
    add_foreign_key :user_stripe_cards, :users
  end
end
