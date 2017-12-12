class RemoveColumnProcedimientoIdFromFunctions < ActiveRecord::Migration
  def change
    remove_column :functions, :procedimiento_id
  end
end
