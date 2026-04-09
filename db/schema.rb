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

ActiveRecord::Schema[8.0].define(version: 2026_04_09_120000) do
  create_table "photo_likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "photo_id", null: false
    t.index ["photo_id"], name: "index_photo_likes_on_photo_id"
    t.index ["user_id", "photo_id"], name: "index_photo_likes_on_user_id_and_photo_id", unique: true
    t.index ["user_id"], name: "index_photo_likes_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.text "url", null: false
    t.string "photographer", null: false
    t.text "photographer_url", null: false
    t.bigint "photographer_id", null: false
    t.string "avg_color", null: false
    t.text "src_original", null: false
    t.text "src_large2x", null: false
    t.text "src_large", null: false
    t.text "src_medium", null: false
    t.text "src_small", null: false
    t.text "src_portrait", null: false
    t.text "src_landscape", null: false
    t.text "src_tiny", null: false
    t.string "alt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "photo_likes_count", default: 0, null: false
    t.index ["external_id"], name: "index_photos_on_external_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "photo_likes", "photos"
  add_foreign_key "photo_likes", "users"
end
