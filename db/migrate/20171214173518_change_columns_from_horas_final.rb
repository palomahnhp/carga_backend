class ChangeColumnsFromHorasFinal < ActiveRecord::Migration
  def change
    change_column :horas_finales, :user_id, :string
    change_column :horas_finales, :position_id, :string
  end
end
