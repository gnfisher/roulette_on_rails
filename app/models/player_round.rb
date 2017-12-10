class PlayerRound
  def initialize(player:, round:)
    @player = player
    @round = round
  end

  def place_wager
    @player.with_lock do
      create_wager
      update_player_money
    end
  end

  def wager_amount
    @wager_amount ||= wager_calculator.calculate
  end

  def winner?
    player_guess == @round.result
  end

  private

  def create_wager
    Wager.create!(
      player: @player,
      round: @round,
      amount: wager_amount,
      color_guessed: player_guess,
      winnings: winnings
    )
  end

  def player_guess
    @player_guess ||= RouletteGame.pick_color
  end

  def player_money_after_round
    @player.money - wager_amount + winnings
  end

  def update_player_money
    @player.update!(money: player_money_after_round)
  end

  def wager_calculator
    WagerCalculator.new(player: @player, round: @round)
  end

  def winnings
    @winnings ||= RouletteGame.calculate_winnings(
      round: @round,
      color_guessed: player_guess,
      wager: wager_amount
    )
  end
end
