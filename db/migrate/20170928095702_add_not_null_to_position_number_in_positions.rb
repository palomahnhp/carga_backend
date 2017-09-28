class AddNotNullToPositionNumberInPositions < ActiveRecord::Migration
  def change
    change_column :positions, :position_number, :string, :null => false
  end
end
