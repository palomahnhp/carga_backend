class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.belongs_to :position, index: true
      t.belongs_to :position_type, index: true
      t.string :name
      t.string :function_number
      t.boolean :num_task
      t.boolean :not_norm

      t.timestamps null: false
    end
  end
end
