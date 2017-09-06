class AddIndexToPositions < ActiveRecord::Migration
  def change
    add_index :positions, :position_number, unique: true
  end
end
