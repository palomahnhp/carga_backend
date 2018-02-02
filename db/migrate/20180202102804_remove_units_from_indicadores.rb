class RemoveUnitsFromIndicadores < ActiveRecord::Migration
  def change
    remove_foreign_key :indicadores, column: :unit_id
    remove_column :indicadores, :unit_id
  end
end
