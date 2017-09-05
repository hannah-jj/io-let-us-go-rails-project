class AddColumnItinerary < ActiveRecord::Migration[5.1]
  def change
  	add_column :itineraries, :meet_day, :date
  	change_column :itineraries, :meet_time, :time
  end
end
