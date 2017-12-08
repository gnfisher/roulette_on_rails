class AddRoundToWagers < ActiveRecord::Migration
  def change
    add_reference :wagers, :round, index: true, foreign_key: true
  end
end
