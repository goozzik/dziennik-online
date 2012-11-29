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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121129141834) do

  create_table "absences", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.integer  "absence_report_id"
    t.integer  "required"
    t.integer  "justified"
    t.integer  "unexcused"
    t.integer  "late"
    t.integer  "month"
    t.integer  "week"
    t.time     "end_time"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "absences", ["school_class_id"], :name => "index_absences_on_school_class_id"
  add_index "absences", ["semester_id"], :name => "index_absences_on_semester_id"

  create_table "average_semestral_marks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.float    "average"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "average_semestral_marks", ["student_id", "semester_id"], :name => "index_average_semestral_marks_on_student_id_and_semester_id", :unique => true

  create_table "behavior_marks", :force => true do |t|
    t.integer  "semester_id"
    t.integer  "school_class_id"
    t.integer  "student_id"
    t.string   "mark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "bells", :force => true do |t|
    t.integer  "school_id"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bells", ["school_id"], :name => "index_bells_on_school_id"

  create_table "descriptions", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "semester_id"
    t.string   "desc_type"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "descriptions", ["semester_id"], :name => "index_descriptions_on_semester_id"
  add_index "descriptions", ["subject_id"], :name => "index_descriptions_on_subject_id"

  create_table "documents", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "school_id"
    t.string   "name"
    t.string   "description"
    t.string   "document"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "documents", ["school_class_id"], :name => "index_documents_on_school_class_id"

  create_table "lessons", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "time_table_id"
    t.integer  "number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "lessons", ["subject_id"], :name => "index_lessons_on_subject_id"
  add_index "lessons", ["time_table_id"], :name => "index_lessons_on_time_table_id"

  create_table "marks", :force => true do |t|
    t.integer  "semester_id"
    t.integer  "student_id"
    t.integer  "subject_id"
    t.integer  "description_id"
    t.string   "mark"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "marks", ["description_id"], :name => "index_marks_on_description_id"
  add_index "marks", ["student_id"], :name => "index_marks_on_student_id"

  create_table "messages", :force => true do |t|
    t.integer  "school_class_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "teacher",    :default => false
    t.boolean  "admin",      :default => false
    t.boolean  "director",   :default => false
    t.boolean  "student",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "school_class_id"
    t.integer  "teacher_id"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "notes", ["school_class_id"], :name => "index_notes_on_school_class_id"
  add_index "notes", ["user_id"], :name => "index_notes_on_user_id"

  create_table "profile_templates", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "start_year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profile_templates_subject_templates", :id => false, :force => true do |t|
    t.integer "profile_template_id"
    t.integer "subject_template_id"
  end

  create_table "school_classes", :force => true do |t|
    t.integer  "school_id"
    t.integer  "teacher_id"
    t.integer  "semester_id"
    t.integer  "yearbook"
    t.integer  "grade"
    t.integer  "period"
    t.string   "profile"
    t.string   "letter"
    t.boolean  "active"
    t.integer  "profile_template_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "school_classes", ["school_id"], :name => "index_school_classes_on_school_id"

  create_table "schools", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schools", ["user_id"], :name => "index_schools_on_user_id"

  create_table "semesters", :force => true do |t|
    t.integer  "school_id"
    t.integer  "semester"
    t.integer  "start_year"
    t.integer  "end_year"
    t.boolean  "active",     :default => false
    t.boolean  "archived",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "semesters", ["school_id"], :name => "index_semesters_on_school_id"

  create_table "semestral_marks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "semester_id"
    t.integer  "subject_id"
    t.integer  "school_class_id"
    t.string   "mark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "semestral_marks", ["semester_id"], :name => "index_semestral_marks_on_semester_id"
  add_index "semestral_marks", ["subject_id"], :name => "index_semestral_marks_on_subject_id"

  create_table "subject_templates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "subject_template_id"
    t.boolean  "deleted"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "active",              :default => true
  end

  add_index "subjects", ["school_class_id"], :name => "index_subjects_on_school_class_id"
  add_index "subjects", ["subject_template_id"], :name => "index_subjects_on_subject_template_id"

  create_table "time_tables", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "week_day"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "time_tables", ["school_class_id"], :name => "index_time_tables_on_school_class_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "individual"
    t.boolean  "boarding_school"
    t.integer  "school_class_id"
    t.integer  "school_id"
    t.integer  "semester_id"
    t.integer  "teacher_id"
    t.string   "role"
    t.boolean  "deleted"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["school_class_id"], :name => "index_users_on_school_class_id"
  add_index "users", ["school_id"], :name => "index_users_on_school_id"
  add_index "users", ["semester_id"], :name => "index_users_on_semester_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
