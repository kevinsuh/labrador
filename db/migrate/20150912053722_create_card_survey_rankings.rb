class CreateCardSurveyRankings < ActiveRecord::Migration
  def change
    create_table :card_survey_rankings do |t|
      t.references :user, index: true
      t.references :occasion, index: true
      t.references :relationship, index: true
      t.references :flavor, index: true
      t.integer :first_card_id
      t.integer :second_card_id
      t.integer :third_card_id
      t.integer :fourth_card_id
      t.integer :fifth_card_id
      t.integer :sixth_card_id
      t.integer :seventh_card_id
      t.integer :eighth_card_id

      t.timestamps null: false
    end
    add_foreign_key :card_survey_rankings, :users
    add_foreign_key :card_survey_rankings, :occasions
    add_foreign_key :card_survey_rankings, :relationships
    add_foreign_key :card_survey_rankings, :flavors
  end
end
