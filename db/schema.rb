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

ActiveRecord::Schema.define(version: 20170113140714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "categories",                     array: true
    t.string   "platforms",                      array: true
    t.string   "permalink"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "tagline"
    t.string   "product_hunt_url"
    t.string   "venture_beat_url"
    t.string   "languages",                      array: true
    t.string   "amazon_echo_url"
    t.string   "android_url"
    t.string   "discord_url"
    t.string   "email_url"
    t.string   "imessage_url"
    t.string   "ios_url"
    t.string   "kik_url"
    t.string   "messenger_url"
    t.string   "skype_url"
    t.string   "slack_url"
    t.string   "sms_url"
    t.string   "telegram_url"
    t.string   "twitter_url"
    t.string   "web_url"
    t.index ["categories"], name: "index_bots_on_categories", using: :gin
    t.index ["permalink"], name: "index_bots_on_permalink", using: :btree
    t.index ["platforms"], name: "index_bots_on_platforms", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
