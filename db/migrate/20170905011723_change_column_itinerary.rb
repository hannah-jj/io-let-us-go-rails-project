class ChangeColumnItinerary < ActiveRecord::Migration[5.1]
  def change
  	change_column :itineraries, :meet_time, :timestamp
  end
end
