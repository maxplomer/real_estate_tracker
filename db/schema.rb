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

ActiveRecord::Schema.define(version: 20141213031635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.integer  "property_id", null: false
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.string   "email",       null: false
    t.string   "company",     null: false
    t.string   "phone",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positive_vs_negative_leverages", force: true do |t|
    t.integer  "user_id",            null: false
    t.float    "purchase_price",     null: false
    t.float    "cap_rate",           null: false
    t.float    "loan_amount",        null: false
    t.float    "low_interest_rate",  null: false
    t.float    "high_interest_rate", null: false
    t.boolean  "interest_only",      null: false
    t.integer  "amortization",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.integer  "user_id",                null: false
    t.string   "address",                null: false
    t.string   "floor",                  null: false
    t.integer  "asking_rent",            null: false
    t.integer  "rsf_available",          null: false
    t.float    "income",                 null: false
    t.float    "expenses",               null: false
    t.float    "purchase_price",         null: false
    t.float    "interest_rate",          null: false
    t.float    "loan_amount",            null: false
    t.boolean  "interest_only",          null: false
    t.integer  "amortization",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "floorplan_file_name"
    t.string   "floorplan_content_type"
    t.integer  "floorplan_file_size"
    t.datetime "floorplan_updated_at"
  end

  create_table "showings", force: true do |t|
    t.integer  "property_id", null: false
    t.string   "name",        null: false
    t.string   "title",       null: false
    t.string   "email",       null: false
    t.string   "company",     null: false
    t.string   "phone",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

  create_table "views", force: true do |t|
    t.integer  "property_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
