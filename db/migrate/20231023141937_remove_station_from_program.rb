class RemoveStationFromProgram < ActiveRecord::Migration[7.0]
  def change
    remove_column :programs, :station, :string
  end
end
