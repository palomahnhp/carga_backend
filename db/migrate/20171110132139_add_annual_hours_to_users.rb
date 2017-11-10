class AddAnnualHoursToUsers < ActiveRecord::Migration
  def change
    add_column :users, :annual_hours, :integer
  end
end
