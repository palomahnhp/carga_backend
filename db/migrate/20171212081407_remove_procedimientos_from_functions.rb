class RemoveProcedimientosFromFunctions < ActiveRecord::Migration
  def change
    remove_foreign_key :functions, column: :procedimiento_id
  end
end