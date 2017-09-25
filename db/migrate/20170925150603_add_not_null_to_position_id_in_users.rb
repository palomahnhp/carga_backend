class AddNotNullToPositionIdInUsers < ActiveRecord::Migration
  def change
    change_column :users, :position_id, :integer, :null => false
  end
end
