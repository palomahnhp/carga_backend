class AddForeignKeyToFunctionsProcedimientos < ActiveRecord::Migration
  def change
    add_foreign_key :functions_procedimientos, :functions
    add_foreign_key :functions_procedimientos, :procedimientos
  end
end
