class AddIndexToPrograms < ActiveRecord::Migration[7.0]
  def change
    add_index :programs, [:title, :start_datetime], unique: true
  end
end
