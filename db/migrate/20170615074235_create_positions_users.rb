class CreatePositionsUsers < ActiveRecord::Migration
  def change
    create_table :positions_users do |t|
      t.integer :position_id
      t.integer :user_id
    end
  end
end
