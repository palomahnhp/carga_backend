class AddUniqueToDocumentPositionIdInUsers < ActiveRecord::Migration
  def change
    add_index :users, [:position_id, :document], unique: true
  end
end
