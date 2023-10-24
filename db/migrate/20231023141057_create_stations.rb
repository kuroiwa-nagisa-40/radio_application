class CreateStations < ActiveRecord::Migration[7.0]
  def change
    create_table :stations do |t|
      t.string :station_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :stations, [:station_id, :name], unique: true
  end
end
