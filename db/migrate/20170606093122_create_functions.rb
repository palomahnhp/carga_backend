class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.references :position, index: true, foreign_key: true
      t.string :name
      t.boolean :not_norm

      t.timestamps null: false
    end
  end
end
