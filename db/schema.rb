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

ActiveRecord::Schema.define(version: 20160503105927) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities_profiles", id: false, force: :cascade do |t|
    t.integer "city_id",    null: false
    t.integer "profile_id", null: false
  end

  create_table "devpurchaseds", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "recruiter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "devpurchaseds", ["profile_id", "recruiter_id"], name: "index_devpurchaseds_on_profile_id_and_recruiter_id", unique: true
  add_index "devpurchaseds", ["profile_id"], name: "index_devpurchaseds_on_profile_id"
  add_index "devpurchaseds", ["recruiter_id"], name: "index_devpurchaseds_on_recruiter_id"

  create_table "educations", force: :cascade do |t|
    t.string   "university"
    t.string   "course"
    t.date     "finishdate"
    t.string   "level"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "degreetype"
  end

  add_index "educations", ["profile_id"], name: "index_educations_on_profile_id"

  create_table "expertises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expertises_profiles", id: false, force: :cascade do |t|
    t.integer "expertise_id", null: false
    t.integer "profile_id",   null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "recruiter_id"
    t.integer  "favorited_id"
    t.string   "favorited_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "favorites", ["favorited_type", "favorited_id"], name: "index_favorites_on_favorited_type_and_favorited_id"
  add_index "favorites", ["recruiter_id"], name: "index_favorites_on_recruiter_id"

  create_table "github_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "email"
    t.string   "name"
    t.string   "image"
    t.string   "location"
    t.integer  "public_repo"
    t.integer  "public_gists"
    t.integer  "followers"
    t.integer  "following"
    t.string   "member_since"
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "portfolios", force: :cascade do |t|
    t.text     "description"
    t.integer  "profile_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "portfolios", ["profile_id"], name: "index_portfolios_on_profile_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "bio"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "location"
    t.string   "phone"
    t.string   "experiance"
    t.string   "mostInterest"
    t.string   "cityToWorkIn"
    t.boolean  "willingToRelocate",   default: false
    t.boolean  "workAbroad",          default: false
    t.string   "salary"
    t.string   "UKauthorization"
    t.string   "TwitterLink"
    t.string   "GithubLink"
    t.string   "StackLink"
    t.string   "DribbbleLink"
    t.string   "MediumLink"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "score"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "whatAmI"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "recruiters", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "recruiters", ["email"], name: "index_recruiters_on_email", unique: true
  add_index "recruiters", ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skillsets", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "skillsets", ["profile_id"], name: "index_skillsets_on_profile_id"
  add_index "skillsets", ["skill_id"], name: "index_skillsets_on_skill_id"

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "works", force: :cascade do |t|
    t.string   "companyName"
    t.string   "position"
    t.date     "startDate"
    t.date     "finishDate"
    t.text     "workDescription"
    t.integer  "profile_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "works", ["profile_id"], name: "index_works_on_profile_id"

end
