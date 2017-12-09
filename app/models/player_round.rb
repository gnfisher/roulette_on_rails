class PlayerRound
  def initialize(player:, raining:, round:)
    @player = player
    @raining = raining
    @round = round
  end

  def place_wager
    @player.with_lock do
      Wager.create!(
        player: @player,
        round: @round,
        amount: wager_amount,
        color_guessed: player_guess,
        winnings: winnings
      )
      @player.update!(money: @player.money + winnings)
    end
  end

  def wager_amount
    return money if money < 1_001

    if @raining
      between_4_and_10_percent
    else
      between_8_and_15_percent
    end
  end

  def winner?
    player_guess == @round.result
  end

  private

  def money
    @player.money
  end

  def player_guess
    @player_guess ||= RouletteGame.pick_color
  end

  def winnings
    if winner?
      @winnings ||= RouletteGame.calculate_winnings(
        round: @round,
        color_guessed: player_guess,
        wager: wager_amount
      )
    else
      0
    end
  end

  def between_4_and_10_percent
    start_value = (money * 0.04).ceil
    end_value = (money * 0.10).ceil
    Array(start_value..end_value).sample
  end

  def between_8_and_15_percent
    start_value = (money * 0.08).ceil
    end_value = (money * 0.15).ceil
    Array(start_value..end_value).sample
  end
end
