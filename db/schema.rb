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

ActiveRecord::Schema.define(version: 20140920072542) do

  create_table "categories", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_messages", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "chat_messages", ["user_id"], name: "index_chat_messages_on_user_id", using: :btree

  create_table "check_onlines", force: true do |t|
    t.datetime "time"
    t.integer  "user_id"
  end

  add_index "check_onlines", ["user_id"], name: "index_check_onlines_on_user_id", using: :btree

  create_table "game_requests", force: true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_requests", ["category_id"], name: "index_game_requests_on_category_id", using: :btree
  add_index "game_requests", ["user_id"], name: "index_game_requests_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
  end

  create_table "groups_to_roles", force: true do |t|
    t.integer  "group_id"
    t.integer  "page_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_to_roles", ["group_id"], name: "index_groups_to_roles_on_group_id", using: :btree

  create_table "questions", force: true do |t|
    t.text     "question"
    t.string   "a"
    t.string   "b"
    t.string   "c"
    t.string   "d"
    t.string   "correct_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "category_id"
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "activation_token"
    t.integer  "login_count"
    t.string   "failed_login_count"
    t.datetime "last_login_at"
    t.string   "last_login_ip"
    t.datetime "birthday"
    t.string   "skype"
    t.string   "icq"
    t.string   "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "group_id"
    t.string   "city"
    t.string   "country"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "sex"
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree

end
