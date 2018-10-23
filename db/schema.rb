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

ActiveRecord::Schema.define(version: 20181023212132) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "blog_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "blog_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.integer "post_id"
    t.integer "blog_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.text     "title_bg"
    t.string   "slug"
  end

  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id"

  create_table "blogs_categories", id: false, force: :cascade do |t|
    t.integer "blog_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "category_posts", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "post_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type"

  create_table "contacts", force: :cascade do |t|
    t.string   "sender"
    t.text     "msg"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "title"
    t.boolean  "seen"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "newslogs", force: :cascade do |t|
    t.text     "title"
    t.text     "txt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolio_screenshots", force: :cascade do |t|
    t.integer  "portfolio_id"
    t.string   "screenshot"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "alt_text"
    t.integer  "explicit_order"
  end

  add_index "portfolio_screenshots", ["portfolio_id"], name: "index_portfolio_screenshots_on_portfolio_id"

  create_table "portfolio_titlebgs", force: :cascade do |t|
    t.text    "title_bg"
    t.text    "title_bg_tablet"
    t.text    "title_bg_mobile"
    t.integer "portfolio_id"
  end

  add_index "portfolio_titlebgs", ["portfolio_id"], name: "index_portfolio_titlebgs_on_portfolio_id"

  create_table "portfolios", force: :cascade do |t|
    t.string   "title"
    t.text     "intro"
    t.text     "description"
    t.text     "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "skillset_id"
    t.date     "realis_date"
    t.text     "theme_color"
    t.string   "slug"
  end

  add_index "portfolios", ["skillset_id"], name: "index_portfolios_on_skillset_id"
  add_index "portfolios", ["slug"], name: "index_portfolios_on_slug", unique: true

  create_table "portfolios_skills", id: false, force: :cascade do |t|
    t.integer "portfolio_id", null: false
    t.integer "skill_id",     null: false
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "text"
    t.string   "slug"
  end

  add_index "posts", ["blog_id"], name: "index_posts_on_blog_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "skills", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "degree"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "work_state_id"
    t.string   "theme_color"
    t.string   "icon"
  end

  add_index "skills", ["work_state_id"], name: "index_skills_on_work_state_id"

  create_table "skillsets", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
    t.integer  "portfolios_count"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "work_states", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
