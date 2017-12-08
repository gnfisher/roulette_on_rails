class AddNotNullConstraintToRoundOnWager < ActiveRecord::Migration
  def change
    change_column_null :wagers, :round_id, false
  end
end
