class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :unit, index: true, foreign_key: true
      t.string :name
      t.string :position_number

      t.timestamps null: false
    end
  end
end
