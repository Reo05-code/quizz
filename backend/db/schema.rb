ActiveRecord::Schema[7.0].define(version: 2024_11_09_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "challenger_id", null: false
    t.bigint "choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenger_id", "choice_id"], name: "index_answers_on_challenger_id_and_choice_id", unique: true
    t.index ["challenger_id"], name: "index_answers_on_challenger_id"
    t.index ["choice_id"], name: "index_answers_on_choice_id"
  end

  create_table "challengers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_challengers_on_name"
    t.index ["score"], name: "index_challengers_on_score"
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "content", null: false
    t.boolean "correct_answer", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["correct_answer"], name: "index_choices_on_correct_answer"
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_quizzes_on_title"
  end

  add_foreign_key "answers", "challengers"
  add_foreign_key "answers", "choices"
  add_foreign_key "choices", "questions"
  add_foreign_key "questions", "quizzes"
end
