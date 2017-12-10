class NightlyDepositJob < ActiveJob::Base
  def perform(player_id:)
    @player_id = player_id

    make_deposit
  end

  private

  def make_deposit
    player.update!(money: new_balance)
  end

  def new_balance
    player.money + 10_000
  end

  def player
    @player ||= Player.find(@player_id)
  end
end
