class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :unit, index: true
      t.string :name
      t.string :email
      t.string :last_name
      t.string :last_name_alt
      t.string :official_position
      t.string :login
      t.string :locale
      t.timestamps null: false
    end
  end
end
