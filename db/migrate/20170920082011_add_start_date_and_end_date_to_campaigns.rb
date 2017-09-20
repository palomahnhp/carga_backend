class AddStartDateAndEndDateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :start_date, :datetime, null: false, default: Time.now
    add_column :campaigns, :end_date, :datetime, null: false, default: Time.now + 86400

    change_column :campaigns, :start_date, :datetime, default: nil
    change_column :campaigns, :end_date, :datetime, default: nil
  end
end
