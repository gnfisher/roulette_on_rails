class AddRainingToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :raining, :boolean
  end
end
