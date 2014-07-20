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

ActiveRecord::Schema.define(version: 20140720194957) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "dynamic_contents", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "title"
    t.text     "mobile_content"
  end

  add_index "dynamic_contents", ["region_id"], name: "index_dynamic_contents_on_region_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "images", force: true do |t|
    t.string   "file"
    t.boolean  "primary",    default: false
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["listing_id"], name: "index_images_on_listing_id"
  add_index "images", ["primary"], name: "index_images_on_primary"

  create_table "inquiries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "comments"
    t.string   "address"
    t.string   "square_footage"
    t.string   "bathrooms"
    t.string   "bedrooms"
    t.text     "updates"
    t.string   "inquiry_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.integer  "price"
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "bedrooms"
    t.float    "bathrooms"
    t.integer  "square_footage"
    t.integer  "lot_size"
    t.integer  "year_built"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
  end

  add_index "listings", ["slug"], name: "index_listings_on_slug", unique: true

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true

  create_table "regions", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "idx_value"
    t.boolean  "linkable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonials", force: true do |t|
    t.text     "body"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
