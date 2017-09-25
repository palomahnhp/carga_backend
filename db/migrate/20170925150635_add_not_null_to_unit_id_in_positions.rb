class AddNotNullToUnitIdInPositions < ActiveRecord::Migration
  def change
    change_column :positions, :unit_id, :integer, :null => false
  end
end
