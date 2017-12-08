class UpdateStartingMoneyForPlayers < ActiveRecord::Migration
  def change
    change_column_default :players, :money, 10_000
  end
end
