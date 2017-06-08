class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :function, index: true
      t.string :time_per
      t.string :num_task
      t.string :min_time
      t.string :avg_time
      t.string :max_time

      t.timestamps null: false
    end
  end
end
