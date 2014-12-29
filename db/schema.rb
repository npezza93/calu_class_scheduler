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

ActiveRecord::Schema.define(version: 20141228170638) do

  create_table "courses", force: true do |t|
    t.string   "subject"
    t.integer  "course"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curriculums", force: true do |t|
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "curriculums", ["course_id"], name: "index_curriculums_on_course_id"

  create_table "days_times", force: true do |t|
    t.string   "days"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offerings", force: true do |t|
    t.integer  "course_id"
    t.integer  "days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "offerings", ["user_id"], name: "index_offerings_on_user_id"

  create_table "prerequisites", id: false, force: true do |t|
    t.integer  "parent_course_id"
    t.integer  "prerequisite_course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transcripts", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transcripts", ["course_id"], name: "index_transcripts_on_course_id"
  add_index "transcripts", ["user_id"], name: "index_transcripts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "administrator",          default: false
    t.boolean  "advisor",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "advised_by"
  end

end
