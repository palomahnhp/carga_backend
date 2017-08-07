class CreateUserDirs < ActiveRecord::Migration
  def change
    create_table :user_dirs do |t|

      t.timestamps null: false
    end
  end
end
