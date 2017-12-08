class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :result, null: false

      t.timestamps null: false
    end
    add_index :rounds, :result
  end
end
