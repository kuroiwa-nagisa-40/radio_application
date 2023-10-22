class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.string :station, null:false
      t.string :title, null: false
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.text :information
      t.string :performer
      t.string :email
      t.integer :time, null: false

      t.timestamps
    end
  end
end
