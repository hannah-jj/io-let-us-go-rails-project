class RenameColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :event_users, :user_id, :participant_id
  end
end
