# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_14_160513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "item_name", null: false
    t.integer "price", null: false
    t.string "image"
    t.string "url", null: false
    t.bigint "wish_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "save_list", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
    t.index ["wish_list_id"], name: "index_items_on_wish_list_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "text", null: false
    t.string "message_image", null: false
    t.string "select_item", null: false
    t.bigint "user_id"
    t.bigint "wish_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["wish_list_id"], name: "index_messages_on_wish_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wish_lists", force: :cascade do |t|
    t.string "list_name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wish_lists_on_user_id"
  end

  add_foreign_key "items", "users"
  add_foreign_key "items", "wish_lists"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "wish_lists"
  add_foreign_key "wish_lists", "users"
end
