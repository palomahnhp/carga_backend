class CreateSubprocesos < ActiveRecord::Migration
  def change
    create_table :subprocesos do |t|
      t.references :proceso, index: true, foreign_key: true
      t.string :descripcion
      
      t.timestamps null: false
    end
  end
end
