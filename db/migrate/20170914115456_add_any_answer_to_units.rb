class AddAnyAnswerToUnits < ActiveRecord::Migration
  def change
    add_column :units, :any_answer, :boolean, default: false
  end
end
