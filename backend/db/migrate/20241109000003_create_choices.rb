# db/migrate/20241109000003_create_choices.rb
class CreateChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :choices do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.text :content, null: false
      t.boolean :correct_answer, null: false, default: false

      t.timestamps
    end

    add_index :choices, :correct_answer
  end
end
