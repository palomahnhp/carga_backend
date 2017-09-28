class AddNotNullToUnitNumberInUnits < ActiveRecord::Migration
  def change
    change_column :units, :unit_number, :string, :null => false
  end
end
