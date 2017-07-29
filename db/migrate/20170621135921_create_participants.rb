class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :event_users do |t|
      t.integer :event_id
      t.integer :participant_id
      t.string :going

      t.timestamps
    end
  end
end
