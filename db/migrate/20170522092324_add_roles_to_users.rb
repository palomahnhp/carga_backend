class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superadmin_role, :boolean, default: false
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :respondent_role, :boolean, default: true
  end
end
