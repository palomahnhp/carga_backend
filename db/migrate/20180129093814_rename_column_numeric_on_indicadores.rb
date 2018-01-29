class RenameColumnNumericOnIndicadores < ActiveRecord::Migration
  def change
    rename_column :indicadores, :number, :valor_entrada
  end
end
