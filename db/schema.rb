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

ActiveRecord::Schema.define(version: 20170524080410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", force: :cascade do |t|
    t.string   "name"
    t.text     "description_fr"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "categories",                                         array: true
    t.string   "permalink"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "tagline_fr"
    t.string   "product_hunt_url"
    t.string   "venture_beat_url"
    t.string   "languages",                                          array: true
    t.string   "tagline_en"
    t.text     "description_en"
    t.date     "tested_on"
    t.text     "test_en"
    t.text     "test_fr"
    t.string   "status",            default: "pending"
    t.text     "comments"
    t.index "to_tsvector('french'::regconfig, (((name)::text || ' '::text) || description_fr))", name: "bot_search_idx", using: :gin
    t.index ["categories"], name: "index_bots_on_categories", using: :gin
    t.index ["permalink"], name: "index_bots_on_permalink", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "object"
    t.text     "question"
    t.string   "language"
    t.boolean  "done",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.integer "bot_id"
    t.integer "provider_id"
    t.string  "url"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.string   "language"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "summary"
    t.integer  "photo_id"
    t.index ["photo_id"], name: "index_posts_on_photo_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.text     "description_en"
    t.text     "description_fr"
    t.string   "website_url"
    t.string   "directory_url"
    t.string   "code"
    t.boolean  "visible"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.integer  "order"
    t.boolean  "featured"
  end

  create_table "selected_bots", force: :cascade do |t|
    t.integer  "bot_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_id"], name: "index_selected_bots_on_bot_id", using: :btree
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
    t.string   "roles",                  default: [],              array: true
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "posts", "photos"
  add_foreign_key "selected_bots", "bots"
end
