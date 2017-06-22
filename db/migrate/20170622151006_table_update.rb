class TableUpdate < ActiveRecord::Migration[5.1]
  def change
  	drop_table :expenses
  	create_table :itineraries do |t|
      t.integer :event_id
      t.string :note
      t.string :location
      t.time :fun_time

      t.timestamps
    end
    rename_column :events, :event_time, :event_day
  end
end
