# db/migrate/20241109000005_create_answers.rb
class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :challenger, null: false, foreign_key: true, index: true
      t.references :choice, null: false, foreign_key: true, index: true

      t.timestamps
    end

    add_index :answers, [:challenger_id, :choice_id], unique: true
  end
end
