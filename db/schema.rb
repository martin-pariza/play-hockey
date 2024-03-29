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

ActiveRecord::Schema.define(version: 20140717130230) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.date     "date_of_play"
    t.string   "name",               limit: 100
    t.string   "note",               limit: 200
    t.integer  "min_num_of_players"
    t.integer  "max_num_of_players"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",                    default: 1
    t.time     "time_of_play"
  end

  add_index "matches", ["category_id"], name: "index_matches_on_category_id"

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "firstname",       limit: 50
    t.string   "lastname",        limit: 50
    t.string   "name_suffix",     limit: 10
    t.integer  "year_of_birth"
    t.string   "residence",       limit: 100
    t.string   "phone_nr",        limit: 20
    t.integer  "plays_since"
    t.integer  "status_id",                   default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
