class CardSurveyRanking < ActiveRecord::Base
  belongs_to :user
  belongs_to :occasion
  belongs_to :relationship
  belongs_to :flavor
end
