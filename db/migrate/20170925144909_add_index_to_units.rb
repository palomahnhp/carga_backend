class AddIndexToUnits < ActiveRecord::Migration
  def change
    add_index :units, :unit_number, unique: true
  end
end
