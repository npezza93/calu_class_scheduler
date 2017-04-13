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

ActiveRecord::Schema.define(version: 20170413004952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_sets", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "curriculum_category_set_id"
    t.index ["course_id"], name: "index_course_sets_on_course_id"
    t.index ["curriculum_category_set_id"], name: "index_course_sets_on_curriculum_category_set_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "subject", limit: 255
    t.integer "course"
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "credits", default: 3
    t.string "minimum_class_standing", limit: 255
    t.string "minimum_sat_score", limit: 255
    t.string "minimum_pt", limit: 255
    t.text "description"
    t.index ["course"], name: "index_courses_on_course"
    t.index ["subject"], name: "index_courses_on_subject"
  end

  create_table "curriculum_categories", id: :serial, force: :cascade do |t|
    t.string "category", limit: 255
    t.integer "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "minor"
    t.string "set_and_or_flag"
    t.index ["major_id"], name: "index_curriculum_categories_on_major_id"
    t.index ["minor"], name: "index_curriculum_categories_on_minor"
  end

  create_table "curriculum_category_sets", id: :serial, force: :cascade do |t|
    t.integer "curriculum_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "count"
    t.index ["curriculum_category_id"], name: "index_curriculum_category_sets_on_curriculum_category_id"
  end

  create_table "days_times", id: :serial, force: :cascade do |t|
    t.string "days", limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "majors", id: :serial, force: :cascade do |t|
    t.string "major", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offerings", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.integer "days_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "semester_id"
    t.string "section", limit: 255
    t.index ["course_id"], name: "index_offerings_on_course_id"
    t.index ["days_time_id"], name: "index_offerings_on_days_time_id"
    t.index ["semester_id"], name: "index_offerings_on_semester_id"
    t.index ["user_id"], name: "index_offerings_on_user_id"
  end

  create_table "prerequisite_groups", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_prerequisite_groups_on_course_id"
  end

  create_table "prerequisites", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "prerequisite_group_id"
    t.string "minimum_grade", limit: 255
    t.index ["course_id"], name: "index_prerequisites_on_course_id"
    t.index ["prerequisite_group_id"], name: "index_prerequisites_on_prerequisite_group_id"
  end

  create_table "schedule_approvals", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.boolean "approved", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "semester_id"
    t.index ["semester_id"], name: "index_schedule_approvals_on_semester_id"
    t.index ["user_id"], name: "index_schedule_approvals_on_user_id"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "offering_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "semester_id"
    t.index ["offering_id"], name: "index_schedules_on_offering_id"
    t.index ["semester_id"], name: "index_schedules_on_semester_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "schedules_categories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "curriculum_category_id"
    t.integer "semester_id"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["curriculum_category_id"], name: "index_schedules_categories_on_curriculum_category_id"
    t.index ["semester_id"], name: "index_schedules_categories_on_semester_id"
    t.index ["user_id"], name: "index_schedules_categories_on_user_id"
  end

  create_table "schedules_category_courses", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_schedules_category_courses_on_category_id"
    t.index ["course_id"], name: "index_schedules_category_courses_on_course_id"
  end

  create_table "schedules_category_offerings", force: :cascade do |t|
    t.bigint "offering_id"
    t.bigint "category_id"
    t.boolean "hidden", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_schedules_category_offerings_on_category_id"
    t.index ["offering_id"], name: "index_schedules_category_offerings_on_offering_id"
  end

  create_table "semesters", id: :serial, force: :cascade do |t|
    t.string "semester", limit: 255
    t.boolean "active", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transcripts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "grade_c_minus"
    t.boolean "grade_c"
    t.index ["course_id"], name: "index_transcripts_on_course_id"
    t.index ["user_id"], name: "index_transcripts_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.boolean "advisor", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "advised_by"
    t.integer "major_id"
    t.text "minor"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "class_standing", limit: 255
    t.boolean "sat_520"
    t.boolean "sat_580"
    t.boolean "sat_440"
    t.integer "pt_a"
    t.integer "pt_b"
    t.integer "pt_c"
    t.integer "pt_d"
    t.boolean "sat_640"
    t.boolean "sat_700"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "guest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["major_id"], name: "index_users_on_major_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_schedules", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "semester_id"
    t.string "day"
    t.time "start_time"
    t.index ["semester_id"], name: "index_work_schedules_on_semester_id"
    t.index ["user_id"], name: "index_work_schedules_on_user_id"
  end

end
