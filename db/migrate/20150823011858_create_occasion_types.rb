class CreateOccasionTypes < ActiveRecord::Migration
  def change
    create_table :occasion_types do |t|
      t.string :occasion_name
    end
  end
end
