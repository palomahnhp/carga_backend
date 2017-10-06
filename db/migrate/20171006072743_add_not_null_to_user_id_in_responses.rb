class AddNotNullToUserIdInResponses < ActiveRecord::Migration
  def change
    change_column :responses, :user_id, :integer, :null => false
  end
end
