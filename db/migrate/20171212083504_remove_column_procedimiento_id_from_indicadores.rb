class RemoveColumnProcedimientoIdFromIndicadores < ActiveRecord::Migration
  def change
    remove_column :indicadores, :procedimiento_id
  end
end
