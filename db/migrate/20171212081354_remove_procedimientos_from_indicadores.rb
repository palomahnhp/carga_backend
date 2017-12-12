class RemoveProcedimientosFromIndicadores < ActiveRecord::Migration
  def change
    remove_foreign_key :indicadores, column: :procedimiento_id
  end
end