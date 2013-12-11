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

ActiveRecord::Schema.define(version: 20131211085007) do

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "topic_tags", force: true do |t|
    t.integer "topic_id", null: false
    t.integer "tag_id",   null: false
  end

  add_index "topic_tags", ["topic_id", "tag_id"], name: "index_topic_tags_on_topic_id_and_tag_id", unique: true

  create_table "topics", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "file"
    t.string   "analyzed_salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "analyzed_author"
    t.string   "status",              default: "inbox"
    t.string   "manual_salary"
    t.string   "manual_memo"
    t.datetime "analyzed_release_at"
    t.string   "analyzed_company"
  end

  add_index "topics", ["file"], name: "index_topics_on_file", unique: true
  add_index "topics", ["url"], name: "index_topics_on_url", unique: true

end
