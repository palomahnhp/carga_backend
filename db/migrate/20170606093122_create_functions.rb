class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.belongs_to :position, index: true
      t.string :name
      t.string :function_number

      t.timestamps null: false
    end
  end
end
