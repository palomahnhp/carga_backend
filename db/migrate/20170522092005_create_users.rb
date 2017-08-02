class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.belongs_to :position, index: true
      t.string :user_num
      t.string :login
      t.string :name
      t.string :last_name
      t.string :last_name_alt
      t.string :document
      t.string :email
      t.string :phone_number
      t.string :personal_number
      t.column :user_role, :integer, default: 0

      t.timestamps null: false
    end
  end
end
