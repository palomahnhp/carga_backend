class CreateJoinTableIndicadorProcedimiento < ActiveRecord::Migration
  def change
    create_join_table :indicadores, :procedimientos do |t|
      t.index [:indicador_id, :procedimiento_id], name: 'indicador_procedimiento'
      t.index [:procedimiento_id, :indicador_id], name: 'procedimiento_indicador'
    end
  end
end
