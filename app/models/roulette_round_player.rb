class RouletteRoundPlayer
  def initialize(players)
    @players = players
  end

  def play
    @players.each do |player|
      PlayerWager.
        new(player: player, raining: raining, round: round).
        place_wager
    end
  end

  private

  def raining
    @raining ||= WeatherChecker.raining?
  end

  def round
    @round ||= Round.create!(result: round_result)
  end

  def round_result
    @round_result ||= RouletteGame.pick_color
  end
end
