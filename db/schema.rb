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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110710072734) do

  create_table "fleets", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scope"
    t.boolean  "display_pilot_count"
    t.boolean  "display_fc_info"
    t.string   "fc"
    t.string   "xo"
    t.string   "created_by"
    t.string   "corp_name"
    t.string   "alliance_name"
    t.boolean  "direct_access"
    t.integer  "users_count"
    t.time     "deleted_at"
  end

  create_table "global_admins", :force => true do |t|
    t.string   "char_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "global_admins", ["char_name"], :name => "index_global_admins_on_char_name", :unique => true

  create_table "reports", :force => true do |t|
    t.string   "char_name"
    t.string   "solar_system_name"
    t.integer  "reds"
    t.integer  "neutrals"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fleet_id"
  end

  add_index "reports", ["solar_system_name"], :name => "index_reports_on_solar_system_name"

  create_table "tags", :force => true do |t|
    t.string   "text",                       :null => false
    t.integer  "usage_count", :default => 0, :null => false
    t.boolean  "favorite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "char_name"
    t.string   "corp_name"
    t.string   "alliance_name"
    t.string   "station_name"
    t.string   "solar_system_name"
    t.string   "constellation_name"
    t.string   "region_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fleet_id"
    t.datetime "changed_at"
    t.integer  "tag_id"
  end

  add_index "users", ["char_name"], :name => "index_users_on_char_name", :unique => true

end
