class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :name
      t.string :function_number
      t.timestamps null: false
    end
  end
end
