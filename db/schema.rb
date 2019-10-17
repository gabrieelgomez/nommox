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

ActiveRecord::Schema.define(version: 2019_10_17_184208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "identity"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "channel"
    t.string "token"
  end

  create_table "airlines", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["country_id"], name: "index_airlines_on_country_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "code"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_bookings_on_case_id"
  end

  create_table "carousel_configurations", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "case_causes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "case_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string "video_self"
    t.integer "hours_late", default: 0
    t.boolean "notifications_enabled", default: false
    t.string "case_cause_ids", default: [], array: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "done", default: false
    t.bigint "case_status_id"
    t.string "delayReason"
    t.string "cancelTime"
    t.string "overbookingBenefit"
    t.string "baggageProblem"
    t.string "claimForm"
    t.string "bills"
    t.string "baggageBills"
    t.string "baggageDate"
    t.string "belongingsValue"
    t.string "valueStatement"
    t.index ["case_status_id"], name: "index_cases_on_case_status_id"
    t.index ["user_id"], name: "index_cases_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "text"
    t.bigint "user_id"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_comments_on_case_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companions", force: :cascade do |t|
    t.string "names"
    t.string "surnames"
    t.string "identification_document"
    t.string "passport"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_companions_on_booking_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "identity"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "departure_airport_code"
    t.string "arrival_airport_code"
    t.string "departure_airport_name"
    t.string "arrival_airport_name"
    t.datetime "date"
    t.string "hour"
    t.string "flight_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "case_id"
    t.string "airline"
    t.index ["case_id"], name: "index_flights_on_case_id"
  end

  create_table "inconveniences", force: :cascade do |t|
    t.boolean "lost_connection", default: false
    t.boolean "lost_event", default: false
    t.text "description"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["case_id"], name: "index_inconveniences_on_case_id"
  end

  create_table "letters", force: :cascade do |t|
    t.bigint "country_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_letters_on_country_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_provinces_on_city_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "call_sid"
    t.string "record_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "code"
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_reservations_on_case_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
    t.text "apn_key"
    t.string "apn_key_id"
    t.string "team_id"
    t.string "bundle_id"
    t.boolean "feedback_enabled", default: true
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string "device_token"
    t.datetime "failed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer "badge"
    t.string "device_token"
    t.string "sound"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.datetime "delivered_at"
    t.boolean "failed", default: false, null: false
    t.datetime "failed_at"
    t.integer "error_code"
    t.text "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false, null: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids"
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.datetime "fail_after"
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false, null: false
    t.text "notification"
    t.boolean "mutable_content", default: false, null: false
    t.string "external_device_id"
    t.string "thread_id"
    t.boolean "dry_run", default: false, null: false
    t.index ["delivered", "failed", "processing", "deliver_after", "created_at"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))"
  end

  create_table "tests", force: :cascade do |t|
    t.jsonb "videos", default: {}
    t.jsonb "images", default: {}
    t.jsonb "documents", default: {}
    t.jsonb "voices", default: {}
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_tests_on_case_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.jsonb "tickets", default: {}
    t.bigint "case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_tickets_on_case_id"
  end

  create_table "unread_messages", force: :cascade do |t|
    t.string "channel"
    t.integer "messages_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone"
    t.string "country_id"
    t.string "province_id"
    t.string "city_id"
    t.string "identification_document"
    t.string "passport"
    t.string "firm"
    t.string "video"
    t.bigint "role_id"
    t.string "identification_document_back"
    t.string "identification_document_front"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "airlines", "countries"
  add_foreign_key "bookings", "cases"
  add_foreign_key "cases", "case_statuses"
  add_foreign_key "cases", "users"
  add_foreign_key "cities", "countries"
  add_foreign_key "comments", "cases"
  add_foreign_key "comments", "users"
  add_foreign_key "companions", "bookings"
  add_foreign_key "flights", "cases"
  add_foreign_key "inconveniences", "cases"
  add_foreign_key "letters", "countries"
  add_foreign_key "provinces", "cities"
  add_foreign_key "reservations", "cases"
  add_foreign_key "tests", "cases"
  add_foreign_key "tickets", "cases"
  add_foreign_key "users", "roles"
end
