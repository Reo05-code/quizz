# db/migrate/20241109000002_create_questions.rb
class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true, index: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
