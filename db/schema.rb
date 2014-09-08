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

ActiveRecord::Schema.define(version: 20140908131709) do

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
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree

end
