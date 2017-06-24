class UpdateDateColumns < ActiveRecord::Migration[5.1]
  def change
  	change_column :itineraries, :meet_time, :datetime
  	remove_column :events, :event_day
  	remove_column :events, :location
  end
end
