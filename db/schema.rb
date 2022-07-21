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

ActiveRecord::Schema[7.0].define(version: 2022_07_21_061751) do
  create_table "all_keys", force: :cascade do |t|
    t.string "api_key"
    t.integer "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "created_time"
  end

  create_table "all_words", force: :cascade do |t|
    t.string "word_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "antonyms", force: :cascade do |t|
    t.string "text"
    t.integer "all_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["all_word_id"], name: "index_antonyms_on_all_word_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "api_key"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "definitions", force: :cascade do |t|
    t.string "text"
    t.integer "all_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["all_word_id"], name: "index_definitions_on_all_word_id"
  end

  create_table "examples", force: :cascade do |t|
    t.string "text"
    t.integer "all_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["all_word_id"], name: "index_examples_on_all_word_id"
  end

  create_table "synonyms", force: :cascade do |t|
    t.string "text"
    t.integer "all_word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["all_word_id"], name: "index_synonyms_on_all_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "subscription_type"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "antonyms", "all_words"
  add_foreign_key "api_keys", "users"
  add_foreign_key "definitions", "all_words"
  add_foreign_key "examples", "all_words"
  add_foreign_key "synonyms", "all_words"
end
