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

ActiveRecord::Schema.define(version: 2021_11_09_004922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "culos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.date "limit_date"
    t.date "finished_date"
    t.date "approved_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.date "limit_date"
    t.date "finished_date"
    t.date "approved_date"
    t.bigint "house_id"
    t.bigint "owner_id"
    t.bigint "assignee_id"
    t.bigint "reviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["house_id"], name: "index_tasks_on_house_id"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
    t.index ["reviewer_id"], name: "index_tasks_on_reviewer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "owner", default: false
    t.bigint "house_id"
    t.date "birthdate"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["house_id"], name: "index_users_on_house_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "tasks", "houses"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "owner_id"
  add_foreign_key "tasks", "users", column: "reviewer_id"
  add_foreign_key "users", "houses"
end
