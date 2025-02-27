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

ActiveRecord::Schema.define(version: 5) do

  create_table "constructors", force: :cascade do |t|
    t.string "name"
    t.string "nationality"
    t.float "tech_factor"
    t.integer "game_id"
    t.integer "budget"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name"
    t.string "second_name"
    t.string "nationality"
    t.integer "age"
    t.string "constructor_id"
    t.integer "price"
    t.float "skill_factor"
    t.integer "game_id"
  end

  create_table "finishing_positions", force: :cascade do |t|
    t.integer "final_position"
    t.integer "race_id"
    t.integer "driver_id"
    t.integer "game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "users_team"
  end

  create_table "races", force: :cascade do |t|
    t.string "circuit"
    t.string "location"
    t.integer "game_id"
  end

end
