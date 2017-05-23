class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :response_level
      t.boolean :active
      t.boolean :pending
      t.boolean :completed
      t.timestamps null: false
    end
  end
end
