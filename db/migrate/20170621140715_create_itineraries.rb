class CreateItineraries < ActiveRecord::Migration[5.1]
  def change
    create_table :itineraries do |t|
      t.integer :event_id
      t.string :note
      t.string :location
      t.datetime :meet_time

      t.timestamps
    end
  end
end
