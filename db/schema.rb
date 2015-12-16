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

ActiveRecord::Schema.define(version: 20151214224350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcement_categories", force: :cascade do |t|
    t.string   "name",                      null: false
    t.integer  "position"
    t.boolean  "visible",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "announcements", force: :cascade do |t|
    t.integer  "announcements_id"
    t.string   "title",            limit: 100,                null: false
    t.text     "descrption",                                  null: false
    t.date     "date_of_start",                               null: false
    t.integer  "price_per_hour",                              null: false
    t.integer  "price_per_day"
    t.integer  "positon"
    t.boolean  "visible",                      default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "announcements", ["announcements_id"], name: "index_announcements_on_announcements_id", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "visible",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name",       limit: 30, null: false
    t.string   "password_digest"
    t.string   "first_name",      limit: 40, null: false
    t.string   "second_name",     limit: 40, null: false
    t.string   "email",           limit: 60, null: false
    t.string   "phone",                      null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "users", ["user_name"], name: "index_users_on_user_name", using: :btree

end
