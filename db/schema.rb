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

ActiveRecord::Schema.define(version: 20170914115456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "functions", force: :cascade do |t|
    t.integer  "position_id"
    t.string   "name"
    t.boolean  "not_norm"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "functions", ["position_id"], name: "index_functions_on_position_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.integer  "unit_id"
    t.string   "name"
    t.string   "position_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
  end

  add_index "positions", ["position_number"], name: "index_positions_on_position_number", unique: true, using: :btree
  add_index "positions", ["slug"], name: "index_positions_on_slug", unique: true, using: :btree
  add_index "positions", ["unit_id"], name: "index_positions_on_unit_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "function_id"
    t.string   "time_per"
    t.string   "num_task"
    t.string   "min_time"
    t.string   "avg_time"
    t.string   "max_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "responses", ["function_id"], name: "index_responses_on_function_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "alias"
    t.string   "unit_number"
    t.string   "cod_area"
    t.string   "area_name"
    t.string   "cod_dir"
    t.string   "dir_name"
    t.string   "cod_subdir"
    t.string   "subdir_name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "any_answer",  default: false
  end

  add_index "units", ["campaign_id"], name: "index_units_on_campaign_id", using: :btree

  create_table "user_dirs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "pernr"
    t.string   "nif"
    t.string   "ayre"
    t.string   "last_name"
    t.string   "last_name_alt"
    t.string   "name"
    t.string   "position_id"
    t.string   "position_des"
    t.string   "functional_unit_id"
    t.string   "functional_unit_des"
    t.string   "organic_code"
    t.string   "category"
    t.string   "category_den"
    t.string   "level"
    t.string   "personal_area"
    t.string   "personal_area_den"
    t.string   "email"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "user_dirs", ["user_id"], name: "index_user_dirs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_num"
    t.string   "login"
    t.string   "name"
    t.string   "last_name"
    t.string   "last_name_alt"
    t.string   "document"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "user_role",     default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "position_id"
    t.datetime "start_date"
    t.datetime "end_date"
  end

  add_index "users", ["position_id"], name: "index_users_on_position_id", using: :btree

  add_foreign_key "functions", "positions"
  add_foreign_key "positions", "units"
  add_foreign_key "responses", "functions"
  add_foreign_key "responses", "users"
  add_foreign_key "units", "campaigns"
  add_foreign_key "user_dirs", "users"
  add_foreign_key "users", "positions"
end
