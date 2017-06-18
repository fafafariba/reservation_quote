# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170618192557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "day_prices", force: :cascade do |t|
    t.date "date"
    t.decimal "price", precision: 8, scale: 2
    t.bigint "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tax_percent", precision: 8, scale: 2
    t.index ["unit_id"], name: "index_day_prices_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "ad_name"
    t.decimal "tax_percent", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.index ["ad_name"], name: "index_units_on_ad_name", unique: true
    t.index ["city"], name: "index_units_on_city"
    t.index ["country"], name: "index_units_on_country"
    t.index ["state"], name: "index_units_on_state"
  end

  add_foreign_key "day_prices", "units"
end
