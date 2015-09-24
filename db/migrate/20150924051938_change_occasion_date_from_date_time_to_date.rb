class ChangeOccasionDateFromDateTimeToDate < ActiveRecord::Migration
  def change
  	change_column :recipient_occasions, :occasion_date, :date
  end
end
