# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081101222603) do

  create_table "fill_ups", :force => true do |t|
    t.integer  "vehicle_id"
    t.date     "date",                                         :null => false
    t.integer  "odometer",                    :default => 0,   :null => false
    t.integer  "cost_in_cents",                                :null => false
    t.float    "gallons",                     :default => 0.0, :null => false
    t.string   "brand",         :limit => 64
    t.integer  "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "elapsed_miles"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "is_admin",                                 :default => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "vehicles", :force => true do |t|
    t.string   "name",       :limit => 64,                :null => false
    t.string   "make",       :limit => 32
    t.string   "model",      :limit => 32
    t.integer  "year"
    t.integer  "miles",                    :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

end
