class CreateHorasFinal < ActiveRecord::Migration
  def change
    create_table :horas_finales do |t|
      t.references :user, index: true, foreign_key: true
      t.string :productividad_persona
      t.float :horas_th_semanales
      t.string :situacion_31dic_2016
      t.integer :reduccion_jornada
      t.string :clase_absentismo
      t.integer :jubilaciones_parciales
      t.float :total_horas_semana
      t.datetime :fecha_absentismo_inicio
      t.datetime :fecha_absentismo_fin
      t.datetime :fecha_puesto_inicio
      t.datetime :fecha_puesto_fin
      t.integer :dias_absentismo
      t.integer :dias_bases
      t.integer :dias_laborales
      t.integer :dias_nolaborales
      t.integer :dias_teoricos_trabajados
      t.integer :dias_teoricos_absentismo
      t.integer :semanas_trabajadas
      t.float :total

      t.timestamps null: false
    end
    add_reference :horas_finales, :position, index: true, foreign_key: true
  end
end
