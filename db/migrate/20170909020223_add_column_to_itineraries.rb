class AddColumnToItineraries < ActiveRecord::Migration[5.1]
  def change
    add_column :itineraries, :end_time, :time
  end
end
