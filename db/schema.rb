# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_30_110315) do

  create_table "admins", force: :cascade do |t|
    t.string "provider", default: "google_oauth2"
    t.string "uid"
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "category_access"
    t.boolean "brand_access"
    t.boolean "item_access"
    t.boolean "employee_access"
    t.boolean "storage_access"
    t.boolean "admin_access", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "brands", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_brands_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer "item_id", null: false
    t.text "details", null: false
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_issues_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "brand_id", null: false
    t.string "name", null: false
    t.boolean "status", default: true
    t.text "notes"
    t.string "document"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["employee_id"], name: "index_items_on_employee_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "notifiable_name"
    t.string "details"
    t.boolean "read_status", default: false
    t.string "urgency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "storages", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "total"
    t.integer "buffer"
    t.date "procurement_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_storages_on_category_id"
  end

end
