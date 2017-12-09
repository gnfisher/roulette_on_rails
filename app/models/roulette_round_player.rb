class RouletteRound
  def initialize(players)
    @players = players
  end

  def play
    @players.each do |player|
      PlayerRound.
        new(player: player, round: round).
        place_wager
    end
  end

  private

  def raining
    @raining ||= WeatherChecker.raining?
  end

  def round
    @round ||= Round.create!(result: round_result, raining: raining)
  end

  def round_result
    @round_result ||= RouletteGame.pick_color
  end
end