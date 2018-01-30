class AddForeignKeyUnitsToIndicadores < ActiveRecord::Migration
  def change
    add_reference :indicadores, :unit, index: true
    add_foreign_key :indicadores, :units
  end
end
