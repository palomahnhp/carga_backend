class AddForeignKeyToIndicadoresProcedimientos < ActiveRecord::Migration
  def change
    add_foreign_key :indicadores_procedimientos, :indicadores
    add_foreign_key :indicadores_procedimientos, :procedimientos
  end
end
