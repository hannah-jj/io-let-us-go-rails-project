class AddColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :image, :integer
  end
end
