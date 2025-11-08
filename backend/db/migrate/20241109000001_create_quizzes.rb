# db/migrate/20241109000001_create_quizzes.rb
class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.string :author, null: false

      t.timestamps
    end

    add_index :quizzes, :title
  end
end
