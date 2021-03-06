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

ActiveRecord::Schema.define(version: 4) do

  create_table "admins", primary_key: "num", force: :cascade do |t|
    t.string "id",       limit: 50,  null: false
    t.string "password", limit: 255, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "timecards", force: :cascade do |t|
    t.date    "day"
    t.integer "user_id",             limit: 4
    t.string  "attendance",          limit: 10
    t.string  "leaving",             limit: 10
    t.string  "prearranged_holiday", limit: 15
    t.float   "paid_vacation",       limit: 24
    t.string  "holiday_acquisition", limit: 15
    t.string  "etc",                 limit: 50
  end

  create_table "users", primary_key: "num", force: :cascade do |t|
    t.integer "id",            limit: 4,   null: false
    t.string  "name",          limit: 50,  null: false
    t.integer "department_id", limit: 4,   null: false
    t.string  "password",      limit: 255, null: false
    t.date    "enter",                     null: false
  end

  add_index "users", ["department_id"], name: "fk_rails_f29bf9cdf2", using: :btree

  add_foreign_key "users", "departments"
end
