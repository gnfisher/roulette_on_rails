class AddNotNullToRainingOnRounds < ActiveRecord::Migration
  def change
    change_column_null :rounds, :raining, false
  end
end
