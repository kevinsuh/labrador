class AddMonthAndDayToRecipientOccasions < ActiveRecord::Migration
  def change
    add_column :recipient_occasions, :month, :integer
    add_column :recipient_occasions, :day, :integer
    remove_column :recipient_occasions, :occasion_date, :datetime
  end
end
