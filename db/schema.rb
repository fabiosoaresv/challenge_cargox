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

ActiveRecord::Schema.define(version: 2020_11_01_183018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "cnpj"
    t.string "foundation"
    t.bigint "foundator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["foundator_id"], name: "index_companies_on_foundator_id"
  end

  create_table "coordinators", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "age"
    t.string "hired_at"
    t.bigint "leader_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["leader_id"], name: "index_coordinators_on_leader_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "age"
    t.string "hired_at"
    t.boolean "in_experience"
    t.string "level"
    t.float "salary"
    t.bigint "coordinator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coordinator_id"], name: "index_employees_on_coordinator_id"
  end

  create_table "foundators", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leaders", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "age"
    t.string "department"
    t.bigint "foundator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["foundator_id"], name: "index_leaders_on_foundator_id"
  end

end
