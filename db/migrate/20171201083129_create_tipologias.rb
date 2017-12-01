class CreateTipologias < ActiveRecord::Migration
  def change
    create_table :tipologias do |t|
      t.string :descripcion
      t.string :siglas
      
      t.timestamps null: false
    end
  end
end
