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

ActiveRecord::Schema.define(version: 20170110102718) do

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
    t.index ["categories"], name: "index_bots_on_categories", using: :gin
    t.index ["permalink"], name: "index_bots_on_permalink", using: :btree
    t.index ["platforms"], name: "index_bots_on_platforms", using: :gin
  end

end
