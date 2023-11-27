class AddIndexToProgram < ActiveRecord::Migration[7.0]
  def change
    add_index :programs, :title
    add_index :programs, :start_datetime
  end
end
