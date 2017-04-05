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

ActiveRecord::Schema.define(version: 20170402100000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "response_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["response_id"], name: "index_answers_on_response_id", using: :btree
  end

  create_table "options", force: :cascade do |t|
    t.string   "value"
    t.integer  "question_id"
    t.integer  "selections_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["question_id"], name: "index_options_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "survey_id"
    t.integer  "option_count"
    t.boolean  "required"
    t.boolean  "multi"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_responses_on_survey_id", using: :btree
  end

  create_table "selections", force: :cascade do |t|
    t.integer  "answer_id"
    t.integer  "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_selections_on_answer_id", using: :btree
    t.index ["option_id"], name: "index_selections_on_option_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title",                       null: false
    t.string   "description",                 null: false
    t.integer  "responses_count", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "responses"
  add_foreign_key "options", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "responses", "surveys"
  add_foreign_key "selections", "answers"
  add_foreign_key "selections", "options"
end
