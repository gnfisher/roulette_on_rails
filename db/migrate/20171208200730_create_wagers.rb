class CreateWagers < ActiveRecord::Migration
  def change
    create_table :wagers do |t|
      t.references :player, index: true, foreign_key: true, null: false
      t.integer :amount, null: false
      t.string :color_guessed, null: false
      t.integer :winnings, null: false

      t.timestamps null: false
    end
  end
end
