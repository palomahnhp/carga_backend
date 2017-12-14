class RemoveForeignKeysFromHorasFinal < ActiveRecord::Migration
  def change
    remove_foreign_key :horas_finales, column: :user_id
    remove_foreign_key :horas_finales, column: :position_id
  end
end
