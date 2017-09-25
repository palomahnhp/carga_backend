class AddNotNullToPositionIdInFunctions < ActiveRecord::Migration
  def change
    change_column :functions, :position_id, :integer, :null => false
  end
end
