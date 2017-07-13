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

ActiveRecord::Schema.define(version: 20170705095552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "functions", force: :cascade do |t|
    t.integer  "position_id"
    t.integer  "position_type_id"
    t.string   "name"
    t.string   "function_number"
    t.boolean  "num_task"
    t.boolean  "not_norm"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "functions", ["position_id"], name: "index_functions_on_position_id", using: :btree
  add_index "functions", ["position_type_id"], name: "index_functions_on_position_type_id", using: :btree

  create_table "position_types", force: :cascade do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "position_type_id"
    t.integer  "unit_id"
    t.string   "name"
    t.string   "position_number"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "positions", ["position_type_id"], name: "index_positions_on_position_type_id", using: :btree
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "units", ["campaign_id"], name: "index_units_on_campaign_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "name"
    t.string   "last_name"
    t.string   "last_name_alt"
    t.string   "document"
    t.string   "email"
    t.string   "phone_number"
    t.string   "official_position"
    t.string   "unit_name"
    t.string   "personal_number"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "superadmin_role",   default: false
    t.boolean  "admin_role",        default: false
    t.boolean  "respondent_role",   default: true
  end

end
