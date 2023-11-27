class AddStationToProgram < ActiveRecord::Migration[7.0]
  def change
    add_reference :programs, :station, null: false, foreign_key: true
  end
end
