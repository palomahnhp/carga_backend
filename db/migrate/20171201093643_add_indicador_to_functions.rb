class AddIndicadorToFunctions < ActiveRecord::Migration
  def change
    add_reference :functions, :indicador, index: true, foreign_key: true
  end
end
