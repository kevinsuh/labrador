class CreateCardFlavorTypes < ActiveRecord::Migration
  def change
    create_table :card_flavor_types do |t|
      t.string :card_flavor_name
    end
  end
end
