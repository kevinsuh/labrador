class RenameUserStripeCardsToUserStripeAccounts < ActiveRecord::Migration
  def change
  	rename_table :user_stripe_cards, :user_stripe_accounts
  end
end
