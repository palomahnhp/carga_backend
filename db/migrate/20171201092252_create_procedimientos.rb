class CreateProcedimientos < ActiveRecord::Migration
  def change
    create_table :procedimientos do |t|
      t.references :subproceso, index: true, foreign_key: true
      t.string :descripcion
      
      t.timestamps null: false
    end
  end
end
