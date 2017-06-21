class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :note
      t.integer :organizer_id
      t.integer :group_id

      t.timestamps
    end
  end
end
