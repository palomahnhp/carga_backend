class AddUniqueToNamePositionIdInFunctions < ActiveRecord::Migration
  def change
    add_index :functions, [:position_id, :name], unique: true
  end
end
