# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "me_sections", :force => true do |t|
    t.integer  "section_id"
    t.integer  "me_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_type"
    t.string   "value",        :limit => 4000
  end

  create_table "mes", :force => true do |t|
    t.integer  "user_id"
    t.string   "subscribe_token"
    t.string   "title"
    t.text     "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.string   "subscription_token"
    t.integer  "pos_x"
    t.integer  "pos_y"
    t.boolean  "collapsed",          :default => false
    t.integer  "me_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
