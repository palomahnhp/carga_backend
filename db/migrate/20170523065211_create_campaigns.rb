class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :response_level
      t.boolean :active, default: false
      t.boolean :pending, default: true
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
