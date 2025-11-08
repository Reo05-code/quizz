# db/seeds.rb
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# Clear existing data
Answer.destroy_all
Choice.destroy_all
Question.destroy_all
Challenger.destroy_all
Quiz.destroy_all

puts "✨ Cleared existing data"

# Create Quiz
quiz1 = Quiz.create!(
  title: "Ruby on Rails 基礎クイズ",
  author: "Rails Master"
)

quiz2 = Quiz.create!(
  title: "JavaScript 初級クイズ",
  author: "JS Ninja"
)

puts "✅ Created #{Quiz.count} quizzes"

# Create Questions for Quiz 1
question1_1 = quiz1.questions.create!(
  content: "Rails の MVC アーキテクチャにおいて、ビジネスロジックを担当するのはどれ？"
)

question1_2 = quiz1.questions.create!(
  content: "Rails でデータベースのスキーマを変更する際に使用するものは？"
)

# Create Questions for Quiz 2
question2_1 = quiz2.questions.create!(
  content: "JavaScript で変数を宣言する際、再代入不可な定数を宣言するキーワードは？"
)

puts "✅ Created #{Question.count} questions"

# Create Choices for Question 1-1
question1_1.choices.create!([
  { content: "Model", correct_answer: true },
  { content: "View", correct_answer: false },
  { content: "Controller", correct_answer: false },
  { content: "Router", correct_answer: false }
])

# Create Choices for Question 1-2
question1_2.choices.create!([
  { content: "seeds.rb", correct_answer: false },
  { content: "migration", correct_answer: true },
  { content: "routes.rb", correct_answer: false },
  { content: "schema.rb", correct_answer: false }
])

# Create Choices for Question 2-1
question2_1.choices.create!([
  { content: "var", correct_answer: false },
  { content: "let", correct_answer: false },
  { content: "const", correct_answer: true },
  { content: "function", correct_answer: false }
])

puts "✅ Created #{Choice.count} choices"

# Create Challengers
challenger1 = Challenger.create!(
  name: "田中太郎",
  score: 0
)

challenger2 = Challenger.create!(
  name: "佐藤花子",
  score: 0
)

puts "✅ Created #{Challenger.count} challengers"

# Create Answers (Challenger 1 answers Question 1-1 correctly)
correct_choice = question1_1.choices.find_by(correct_answer: true)
challenger1.answers.create!(choice: correct_choice)
challenger1.update!(score: 10)

# Create Answers (Challenger 2 answers Question 2-1 incorrectly)
wrong_choice = question2_1.choices.find_by(content: "var")
challenger2.answers.create!(choice: wrong_choice)

puts "✅ Created #{Answer.count} answers"

puts <<~SUMMARY

  🎉 Seed data created successfully!

  Summary:
  - Quizzes: #{Quiz.count}
  - Questions: #{Question.count}
  - Choices: #{Choice.count}
  - Challengers: #{Challenger.count}
  - Answers: #{Answer.count}

SUMMARY
