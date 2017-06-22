class ChangeColumn < ActiveRecord::Migration[5.1]
  def change
  	change_column :events, :event_day, :date
  	rename_column :itineraries, :fun_time, :meet_time
  end
end
