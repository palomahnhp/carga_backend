class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.column :status, :integer, default: 0

      t.timestamps null: false
    end
  end
end
