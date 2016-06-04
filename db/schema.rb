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

ActiveRecord::Schema.define(version: 20160602030632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addons", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "source"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "addons", ["document_id"], name: "index_addons_on_document_id", using: :btree

  create_table "afiles", force: :cascade do |t|
    t.integer  "document_id"
    t.binary   "source"
    t.string   "path"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "afiles", ["document_id"], name: "index_afiles_on_document_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "accompanying_files_file_name"
    t.string   "accompanying_files_content_type"
    t.integer  "accompanying_files_file_size"
    t.datetime "accompanying_files_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "attachments", ["document_id"], name: "index_attachments_on_document_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "comment"
    t.integer  "material_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "way"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.integer  "room_id"
    t.string   "left"
    t.string   "top"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "machines", ["room_id"], name: "index_machines_on_room_id", using: :btree

  create_table "presentations", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.string   "comment"
    t.string   "groups",                       array: true
    t.integer  "last_open_slide"
    t.boolean  "auto_open"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "presentations", ["document_id"], name: "index_presentations_on_document_id", using: :btree
  add_index "presentations", ["user_id"], name: "index_presentations_on_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "document_id"
    t.text     "source"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sections", ["document_id"], name: "index_sections_on_document_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "full_name"
    t.string   "password_digest"
    t.integer  "role"
    t.string   "groups"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "addons", "documents"
  add_foreign_key "afiles", "documents"
  add_foreign_key "attachments", "documents"
  add_foreign_key "documents", "users"
  add_foreign_key "machines", "rooms"
  add_foreign_key "presentations", "documents"
  add_foreign_key "presentations", "users"
  add_foreign_key "sections", "documents"
end
