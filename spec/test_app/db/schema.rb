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

ActiveRecord::Schema.define(version: 20140210171856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "angular_blog_blurbs", force: true do |t|
    t.text     "content"
    t.string   "size",       default: "normal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "angular_blog_components", force: true do |t|
    t.integer  "post_id"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.integer  "index"
    t.string   "width"
    t.string   "height"
    t.string   "link"
    t.string   "css_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "angular_blog_components", ["post_id"], name: "index_angular_blog_components_on_post_id", using: :btree
  add_index "angular_blog_components", ["postable_id", "postable_type"], name: "index_angular_blog_components_on_postable_id_and_postable_type", using: :btree

  create_table "angular_blog_headers", force: true do |t|
    t.string   "content"
    t.integer  "size",       default: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "angular_blog_images", force: true do |t|
    t.string   "src"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "css_class",  default: "ab-block-image"
  end

  create_table "angular_blog_post_tags", force: true do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "angular_blog_post_tags", ["post_id"], name: "index_angular_blog_post_tags_on_post_id", using: :btree
  add_index "angular_blog_post_tags", ["tag_id"], name: "index_angular_blog_post_tags_on_tag_id", using: :btree

  create_table "angular_blog_posts", force: true do |t|
    t.boolean  "is_sticky"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "angular_blog_tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "angular_blog_videos", force: true do |t|
    t.string   "identifier"
    t.string   "host",       default: "youtube"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
