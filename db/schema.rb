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

ActiveRecord::Schema.define(version: 20150215155542) do

  create_table "courses", force: true do |t|
    t.string   "subject"
    t.integer  "course"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits",    default: 3
  end

  create_table "curriculum_categories", force: true do |t|
    t.string   "category"
    t.integer  "required_amount_of_credits"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "minor"
  end

  add_index "curriculum_categories", ["major_id"], name: "index_curriculum_categories_on_major_id"

  create_table "curriculum_category_courses", force: true do |t|
    t.integer  "curriculum_category_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "curriculum_category_courses", ["course_id"], name: "index_curriculum_category_courses_on_course_id"
  add_index "curriculum_category_courses", ["curriculum_category_id"], name: "index_curriculum_category_courses_on_curriculum_category_id"

  create_table "days_times", force: true do |t|
    t.string   "days"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majors", force: true do |t|
    t.string   "major"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "needed_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "semester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "needed_courses", ["course_id"], name: "index_needed_courses_on_course_id"
  add_index "needed_courses", ["semester_id"], name: "index_needed_courses_on_semester_id"
  add_index "needed_courses", ["user_id"], name: "index_needed_courses_on_user_id"

  create_table "offerings", force: true do |t|
    t.integer  "course_id"
    t.integer  "days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "semester_id"
  end

  add_index "offerings", ["semester_id"], name: "index_offerings_on_semester_id"
  add_index "offerings", ["user_id"], name: "index_offerings_on_user_id"

  create_table "prerequisites", id: false, force: true do |t|
    t.integer  "parent_course_id"
    t.integer  "prerequisite_course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_approvals", force: true do |t|
    t.integer  "user_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "schedule_approvals", ["semester_id"], name: "index_schedule_approvals_on_semester_id"
  add_index "schedule_approvals", ["user_id"], name: "index_schedule_approvals_on_user_id"

  create_table "schedules", force: true do |t|
    t.integer  "offering_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "schedules", ["offering_id"], name: "index_schedules_on_offering_id"
  add_index "schedules", ["semester_id"], name: "index_schedules_on_semester_id"
  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id"

  create_table "semesters", force: true do |t|
    t.string   "semester"
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transcripts", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade",      default: "NG"
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
    t.integer  "major_id"
    t.text     "minor"
  end

  add_index "users", ["major_id"], name: "index_users_on_major_id"

  create_table "work_days_times", force: true do |t|
    t.string   "days"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_schedules", force: true do |t|
    t.integer  "user_id"
    t.integer  "work_days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "work_schedules", ["semester_id"], name: "index_work_schedules_on_semester_id"
  add_index "work_schedules", ["user_id"], name: "index_work_schedules_on_user_id"
  add_index "work_schedules", ["work_days_time_id"], name: "index_work_schedules_on_work_days_time_id"

end
