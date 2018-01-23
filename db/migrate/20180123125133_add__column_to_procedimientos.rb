class AddColumnToProcedimientos < ActiveRecord::Migration
  def change
    add_column :procedimientos, :cod_procedimiento, :string
  end
end
