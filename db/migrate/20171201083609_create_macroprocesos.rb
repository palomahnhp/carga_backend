class CreateMacroprocesos < ActiveRecord::Migration
  def change
    create_table :macroprocesos do |t|
      t.references :tipologia, index: true, foreign_key: true
      t.string :descripcion
      
      t.timestamps null: false
    end
  end
end
