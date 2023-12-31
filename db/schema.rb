# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_14_125305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "programs", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime", null: false
    t.string "url"
    t.string "performer"
    t.string "email"
    t.integer "time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "station_id", null: false
    t.index ["start_datetime"], name: "index_programs_on_start_datetime"
    t.index ["station_id"], name: "index_programs_on_station_id"
    t.index ["title", "start_datetime", "station_id"], name: "index_programs_on_title_and_start_datetime_and_station_id", unique: true
    t.index ["title"], name: "index_programs_on_title"
  end

  create_table "stations", force: :cascade do |t|
    t.string "station_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id", "name"], name: "index_stations_on_station_id_and_name", unique: true
  end

  add_foreign_key "programs", "stations"
end
