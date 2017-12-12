class CreateJoinTableFunctionProcedimiento < ActiveRecord::Migration
  def change
    create_join_table :functions, :procedimientos do |t|
      t.index [:function_id, :procedimiento_id], name: 'function_procedimiento'
      t.index [:procedimiento_id, :function_id], name: 'procedimiento_function'
    end
  end
end
