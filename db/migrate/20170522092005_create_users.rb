class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :last_name
      t.string :last_name_alt
      t.string :document
      t.string :email
      t.string :phone_number
      t.string :official_position
      t.string :unit_name
      t.string :personal_number

      t.timestamps null: false
    end
  end
end
