class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :document
  end
end
