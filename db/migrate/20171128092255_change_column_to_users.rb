class ChangeColumnToUsers < ActiveRecord::Migration
  def change
    change_column :users, :annual_hours, :numeric, precision: 5, scale: 2
  end
end
