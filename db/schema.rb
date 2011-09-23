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

ActiveRecord::Schema.define(:version => 20110924010932) do

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.text     "describtion"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "download_times",      :default => 0
    t.integer  "attachmentable_id"
    t.string   "attachmentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.text     "describtion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  create_table "evaluations", :force => true do |t|
    t.string   "category",            :default => "good"
    t.integer  "star_rating"
    t.integer  "evaluationable_id"
    t.string   "evaluationable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "category",   :default => "bad"
    t.text     "body"
    t.string   "state",      :default => "pending"
    t.text     "result"
    t.integer  "handler_id"
    t.datetime "handle_at"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.text     "body"
    t.string   "state",                :default => "pending"
    t.integer  "assigner_id"
    t.integer  "accepter_id"
    t.text     "assign_remark"
    t.datetime "assign_at"
    t.text     "solution"
    t.datetime "accept_at"
    t.text     "result"
    t.datetime "finish_at"
    t.integer  "user_id"
    t.integer  "service_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expired_date"
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "state_before_expired"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content"
    t.boolean  "top",        :default => false
    t.string   "category",   :default => "none"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "describtion"
    t.string   "category",           :default => "new_business"
    t.integer  "expired_date_hours"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",        :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",        :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask",                            :default => 0
    t.string   "username"
    t.boolean  "superadmin",                            :default => false
    t.string   "name"
    t.string   "gender",                                :default => "male"
    t.string   "phone_number"
    t.string   "location"
    t.text     "about"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "state",                                 :default => "pending"
    t.integer  "department_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
