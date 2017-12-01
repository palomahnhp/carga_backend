class AddProcedimientoToFunctions < ActiveRecord::Migration
  def change
    add_reference :functions, :procedimiento, index: true, foreign_key: true
  end
end
