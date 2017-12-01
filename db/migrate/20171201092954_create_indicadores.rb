class CreateIndicadores < ActiveRecord::Migration
  def change
    create_table :indicadores do |t|
      t.references :procedimiento, index: true, foreign_key: true
      t.string :descripcion
      
      t.timestamps null: false
    end
    add_column :indicadores, :number, :numeric, null: false
  end
end