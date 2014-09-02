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

ActiveRecord::Schema.define(version: 20140627184837) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",                      default: 0, null: false
    t.integer  "attempts",                      default: 0, null: false
    t.text     "handler",    limit: 2147483647,             null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["match_id"], name: "index_favorites_on_match_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "matches", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "relationship_status"
    t.string   "religion"
    t.string   "gender"
    t.string   "location"
    t.integer  "match_percent"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  add_index "matches", ["user_id"], name: "index_matches_on_user_id", using: :btree

  create_table "shared_interests", force: true do |t|
    t.string   "interest"
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shared_interests", ["match_id"], name: "index_shared_interests_on_match_id", using: :btree
  add_index "shared_interests", ["user_id"], name: "index_shared_interests_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "match_gender"
    t.string   "match_relationship_status"
    t.string   "match_location"
    t.string   "match_religion"
    t.string   "job_status"
    t.integer  "progress_bar",              default: 0
  end

end
