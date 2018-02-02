class AddSubdirToIndicadores < ActiveRecord::Migration
  def change
    add_column :indicadores, :subdir, :string
    add_index :indicadores, :subdir
  end
end
