class AddNotNullToFunctionIdInResponses < ActiveRecord::Migration
  def change
    change_column :responses, :function_id, :integer, :null => false
  end
end
