class RecipientOccasion < ActiveRecord::Base
  belongs_to :recipient
  belongs_to :occasion

  validates :recipient_id, presence: true
	validates :occasion_id, presence: true

	enum status: [ :live, :deleted, :archived ]
end
