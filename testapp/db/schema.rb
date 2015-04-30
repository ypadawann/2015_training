# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150430040917) do

  create_table "departments", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "timecards", force: :cascade do |t|
    t.date    "day"
    t.integer "user_id",    limit: 4
    t.time    "attendance"
    t.time    "leaving"
  end

  add_index "timecards", ["user_id"], name: "fk_rails_72a13e4c12", using: :btree

  create_table "users", force: :cascade do |t|
    t.string  "name",       limit: 255, null: false
    t.integer "department", limit: 4,   null: false
    t.string  "password",   limit: 255, null: false
  end

  add_index "users", ["department"], name: "fk_rails_b22c8fc721", using: :btree

  add_foreign_key "timecards", "users"
  add_foreign_key "users", "departments", column: "department"
end