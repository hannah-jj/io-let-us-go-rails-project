class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :event_id
      t.integer :user_id
      t.float	:amount
      t.string :note
      t.string :status

      t.timestamps
    end
  end
end
