class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.belongs_to :position, index: true
      t.string :name
      t.boolean :not_norm

      t.timestamps null: false
    end
  end
end
