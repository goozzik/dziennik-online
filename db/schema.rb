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

ActiveRecord::Schema.define(:version => 20120422182439) do

  create_table "absences", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_class_id"
    t.integer  "absence_report_id"
    t.date     "date"
    t.integer  "required"
    t.integer  "justified"
    t.integer  "unexcused"
    t.integer  "late"
    t.time     "end_time"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "bells", :force => true do |t|
    t.integer  "school_id"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "descriptions", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "semester_id"
    t.string   "desc_type"
    t.integer  "colour"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.string   "name"
    t.string   "description"
    t.string   "path"
    t.string   "type"
    t.integer  "size"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "lessons", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "time_table_id"
    t.integer  "number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "marks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.integer  "subject_id"
    t.integer  "description_id"
    t.string   "mark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "school_class_id"
    t.integer  "teacher_id"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "school_classes", :force => true do |t|
    t.integer  "school_id"
    t.integer  "teacher_id"
    t.integer  "yearbook"
    t.integer  "year"
    t.string   "profile"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schools", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "semesters", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "semester"
    t.integer  "teacher_id"
    t.boolean  "active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "semestral_marks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.integer  "subject_id"
    t.integer  "mark"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "subjects", :force => true do |t|
    t.integer  "school_id"
    t.integer  "teacher_id"
    t.integer  "school_class_id"
    t.string   "name"
    t.boolean  "deleted"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "time_tables", :force => true do |t|
    t.integer  "school_class_id"
    t.integer  "week_day"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "pesel"
    t.integer  "niu"
    t.string   "street"
    t.string   "city"
    t.string   "zip_code"
    t.string   "province"
    t.string   "telephone"
    t.boolean  "individual"
    t.boolean  "boarding_school"
    t.integer  "school_class_id"
    t.integer  "semester_id"
    t.integer  "teacher_id"
    t.boolean  "student"
    t.boolean  "teacher"
    t.boolean  "admin"
    t.boolean  "superadmin"
    t.boolean  "director"
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
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
