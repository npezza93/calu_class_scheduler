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

ActiveRecord::Schema.define(version: 20160223021512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_sets", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "curriculum_category_set_id"
  end

  add_index "course_sets", ["course_id"], name: "index_course_sets_on_course_id", using: :btree
  add_index "course_sets", ["curriculum_category_set_id"], name: "index_course_sets_on_curriculum_category_set_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "subject"
    t.integer  "course"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits",                default: 3
    t.string   "minimum_class_standing"
    t.string   "minimum_sat_score"
    t.string   "minimum_pt"
  end

  create_table "curriculum_categories", force: :cascade do |t|
    t.string   "category"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "minor"
    t.string   "set_and_or_flag"
  end

  add_index "curriculum_categories", ["major_id"], name: "index_curriculum_categories_on_major_id", using: :btree

  create_table "curriculum_category_sets", force: :cascade do |t|
    t.integer  "curriculum_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  add_index "curriculum_category_sets", ["curriculum_category_id"], name: "index_curriculum_category_sets_on_curriculum_category_id", using: :btree

  create_table "days_times", force: :cascade do |t|
    t.string   "days"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majors", force: :cascade do |t|
    t.string   "major"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "needed_courses", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "semester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needed_courses", ["course_id"], name: "index_needed_courses_on_course_id", using: :btree
  add_index "needed_courses", ["semester_id"], name: "index_needed_courses_on_semester_id", using: :btree
  add_index "needed_courses", ["user_id"], name: "index_needed_courses_on_user_id", using: :btree

  create_table "offerings", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "semester_id"
    t.string   "section"
  end

  add_index "offerings", ["semester_id"], name: "index_offerings_on_semester_id", using: :btree
  add_index "offerings", ["user_id"], name: "index_offerings_on_user_id", using: :btree

  create_table "prerequisite_groups", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prerequisite_groups", ["course_id"], name: "index_prerequisite_groups_on_course_id", using: :btree

  create_table "prerequisites", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prerequisite_group_id"
    t.string   "minimum_grade"
  end

  create_table "schedule_approvals", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "schedule_approvals", ["semester_id"], name: "index_schedule_approvals_on_semester_id", using: :btree
  add_index "schedule_approvals", ["user_id"], name: "index_schedule_approvals_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "offering_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "schedules", ["offering_id"], name: "index_schedules_on_offering_id", using: :btree
  add_index "schedules", ["semester_id"], name: "index_schedules_on_semester_id", using: :btree
  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "semesters", force: :cascade do |t|
    t.string   "semester"
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transcripts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "grade_c_minus"
    t.boolean  "grade_c"
  end

  add_index "transcripts", ["course_id"], name: "index_transcripts_on_course_id", using: :btree
  add_index "transcripts", ["user_id"], name: "index_transcripts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.boolean  "administrator",          default: false
    t.boolean  "advisor",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "advised_by"
    t.integer  "major_id"
    t.text     "minor"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "class_standing"
    t.boolean  "sat_520"
    t.boolean  "sat_580"
    t.boolean  "sat_440"
    t.integer  "pt_a"
    t.integer  "pt_b"
    t.integer  "pt_c"
    t.integer  "pt_d"
    t.boolean  "sat_640"
    t.boolean  "sat_700"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["major_id"], name: "index_users_on_major_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_days_times", force: :cascade do |t|
    t.string   "days"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "work_days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "work_schedules", ["semester_id"], name: "index_work_schedules_on_semester_id", using: :btree
  add_index "work_schedules", ["user_id"], name: "index_work_schedules_on_user_id", using: :btree
  add_index "work_schedules", ["work_days_time_id"], name: "index_work_schedules_on_work_days_time_id", using: :btree

end
