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

ActiveRecord::Schema.define(version: 0) do

  create_table "event_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "event_id",                                                null: false
    t.string  "title",               limit: 100
    t.decimal "total_price",                     precision: 9, scale: 2
    t.decimal "per_person_price",                precision: 9, scale: 2
    t.decimal "child_factor",                    precision: 1, scale: 1
    t.decimal "woman_factor",                    precision: 1, scale: 1
    t.boolean "required_per_person"
    t.index ["event_id"], name: "event_items_events1_idx", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "title", limit: 100, null: false
    t.date   "date",              null: false
    t.index ["title"], name: "title_UNIQUE", unique: true, using: :btree
  end

  create_table "participations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "user_id",  null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "participations_events1_idx", using: :btree
    t.index ["user_id"], name: "participations_users_idx", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name",  limit: 100
    t.string "genre", limit: 1,   default: "m", null: false
  end

  create_table "uses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "participation_id",           null: false
    t.integer "event_item_id",              null: false
    t.string  "type",             limit: 6
    t.index ["event_item_id"], name: "uses_event_items1_idx", using: :btree
    t.index ["participation_id"], name: "uses_participations1_idx", using: :btree
  end

  add_foreign_key "event_items", "events", name: "event_items_events1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "participations", "events", name: "participations_events1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "participations", "users", name: "participations_users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "uses", "event_items", name: "uses_event_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "uses", "participations", name: "uses_participations1", on_update: :cascade, on_delete: :cascade
end
