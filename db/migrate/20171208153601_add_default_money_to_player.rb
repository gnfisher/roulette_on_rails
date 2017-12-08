class AddDefaultMoneyToPlayer < ActiveRecord::Migration
  def change
    change_column_default :players, :money, 1_000
  end
end
