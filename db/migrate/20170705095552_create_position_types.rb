class CreatePositionTypes < ActiveRecord::Migration
  def change
    create_table :position_types do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
