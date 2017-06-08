class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.belongs_to :campaign, index: true
      t.string :name
      t.string :alias
      t.string :unit_number
      t.string :cod_area
      t.string :area_name
      t.string :cod_dir
      t.string :dir_name
      t.string :cod_subdir
      t.string :subdir_name

      t.timestamps null: false
    end
  end
end
