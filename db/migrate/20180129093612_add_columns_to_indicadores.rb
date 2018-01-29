class AddColumnsToIndicadores < ActiveRecord::Migration
  def change
    add_column :indicadores, :realizados, :numeric
    add_column :indicadores, :valor_salida, :numeric
    add_column :indicadores, :procedimiento_id, :integer
  end
end
