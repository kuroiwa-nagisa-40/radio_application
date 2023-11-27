class AddUniqueIndexToPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_index :programs, column: [:title, :start_datetime]
    add_index :programs, [:title, :start_datetime, :station_id], unique: true
  end
end
