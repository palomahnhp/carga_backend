class AddBiColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :labor, :string
    add_column :users, :ayre, :string
    add_column :users, :document2, :string
  end
end
