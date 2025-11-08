# db/migrate/20241109000004_create_challengers.rb
class CreateChallengers < ActiveRecord::Migration[7.0]
  def change
    create_table :challengers do |t|
      t.string :name, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end

    add_index :challengers, :name
    add_index :challengers, :score
  end
end
