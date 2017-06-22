class RenameTable < ActiveRecord::Migration[5.1]
  def change
  	rename_table :participants, :event_users
  end
end
