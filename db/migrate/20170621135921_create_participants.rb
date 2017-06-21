class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :going

      t.timestamps
    end
  end
end
