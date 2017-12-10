class RouletteRound
  def initialize(players)
    @players = players
  end

  def play
    @players.each do |player|
      PlayerRoundJob.perform_later(player_id: player.id, round_id: round.id)
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
