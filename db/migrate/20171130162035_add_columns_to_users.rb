class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :classification, :string
    add_column :users, :group, :string
    add_column :users, :level, :numeric, scale: 5, precision: 2
    add_column :users, :position_address, :string
    add_column :users, :collective, :string
    add_column :users, :data_collecting, :string
    add_column :users, :productivity, :string
    add_column :users, :absenteeism_reason, :string
    add_column :users, :absenteeism_days, :integer
    add_column :users, :journey_reduction, :numeric, scale: 5, precision: 2
  end
end