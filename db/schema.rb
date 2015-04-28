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

ActiveRecord::Schema.define(version: 20150428233657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "response_id"
    t.integer  "question_id"
    t.string   "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "source"
  end

  create_table "assessments", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "text"
    t.text     "more_info"
    t.integer  "section_id"
    t.integer  "assessment_id"
    t.string   "type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "good_answer"
    t.integer  "order"
    t.text     "rendered_text"
    t.text     "rendered_info"
  end

  create_table "responses", force: :cascade do |t|
    t.string   "email"
    t.string   "ip"
    t.string   "location"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "assessment_id"
    t.string   "city"
    t.string   "state",         limit: 2
    t.integer  "zip",           limit: 8
    t.string   "uuid"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.integer  "assessment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
