class CreateProcesos < ActiveRecord::Migration
  def change
    create_table :procesos do |t|
      t.references :macroproceso, index: true, foreign_key: true
      t.string :descripcion
      
      t.timestamps null: false
    end
  end
end
